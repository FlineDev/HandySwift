import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

/// A client to consume a REST API. Uses JSON to encode/decode body data.
@available(iOS 16, macOS 13, tvOS 16, watchOS 9, *)
public final class RESTClient: Sendable {
   public enum RequestError: Error, LocalizedError, Sendable {
      public typealias Context = String

      case failedToEncodeBody(Error, Context?)
      case failedToLoadData(Error, Context?)
      case failedToDecodeSuccessBody(Error, Context?)
      case failedToDecodeClientErrorBody(Error, Context?)
      case clientError(String, Context?)
      case unexpectedResponseType(URLResponse, Context?)
      case unexpectedStatusCode(Int, Context?)

      public var errorDescription: String? {
         switch self {
         case .failedToEncodeBody(let error, _):
            "\(self.errorContext) Failed to encode body: \(error.localizedDescription)"
         case .failedToLoadData(let error, _):
            "\(self.errorContext) Failed to load data: \(error.localizedDescription)"
         case .failedToDecodeSuccessBody(let error, _):
            "\(self.errorContext) Failed to decode success body: \(error.localizedDescription)"
         case .failedToDecodeClientErrorBody(let error, _):
            "\(self.errorContext) Failed to decode client error body: \(error.localizedDescription)"
         case .clientError(let string, _):
            "\(self.errorContext) \(string)"
         case .unexpectedResponseType(let urlResponse, _):
            "\(self.errorContext) Unexpected response type (non-HTTP): \(String(describing: type(of: urlResponse)))"
         case .unexpectedStatusCode(let int, _):
            "\(self.errorContext) Unexpected status code: \(int)"
         }
      }

      private var errorContext: String {
         switch self {
         case .failedToEncodeBody(_, let context), .failedToLoadData(_, let context), .failedToDecodeSuccessBody(_, let context),
               .failedToDecodeClientErrorBody(_, let context), .clientError(_, let context):
            if let context {
               return "[\(context): Client Error]"
            } else {
               return "[Client Error]"
            }

         case .unexpectedResponseType(_, let context), .unexpectedStatusCode(_, let context):
            if let context {
               return "[\(context): Server Error]"
            } else {
               return "[Server Error]"
            }
         }
      }
   }

   public enum HTTPMethod: String, Sendable {
      case get = "GET"
      case post = "POST"
      case put = "PUT"
      case patch = "PATCH"
      case delete = "DELETE"
   }

   public enum Body: Sendable {
      case binary(Data)
      case json(Encodable & Sendable)
      case string(String)
      case form([URLQueryItem])

      var contentType: String {
         switch self {
         case .binary: return "application/octet-stream"
         case .json: return "application/json"
         case .string: return "text/plain"
         case .form: return "application/x-www-form-urlencoded"
         }
      }

      func httpData() throws -> Data {
         switch self {
         case .binary(let data):
            return data

         case .json(let json):
            return try JSONEncoder().encode(json)

         case .string(let string):
            return Data(string.utf8)

         case .form(let queryItems):
            var urlComponents = URLComponents(string: "https://example.com")!
            urlComponents.queryItems = queryItems
            return Data(urlComponents.percentEncodedQuery!.utf8)
         }
      }
   }

   let baseURL: URL
   let baseHeaders: [String: String]
   let baseQueryItems: [URLQueryItem]
   let jsonEncoder: JSONEncoder
   let jsonDecoder: JSONDecoder
   let baseErrorContext: String?
   let errorBodyToMessage: @Sendable (Data) throws -> String

   // no need to pass 'application/json' to `baseHeaders`, it'll automatically be added of a body is sent
   public init(
      baseURL: URL,
      baseHeaders: [String: String] = [:],
      baseQueryItems: [URLQueryItem] = [],
      jsonEncoder: JSONEncoder = .init(),
      jsonDecoder: JSONDecoder = .init(),
      baseErrorContext: String? = nil,
      errorBodyToMessage: @Sendable @escaping (Data) throws -> String
   ) {
      self.baseURL = baseURL
      self.baseHeaders = baseHeaders
      self.baseQueryItems = baseQueryItems
      self.jsonEncoder = jsonEncoder
      self.jsonDecoder = jsonDecoder
      self.baseErrorContext = baseErrorContext
      self.errorBodyToMessage = errorBodyToMessage
   }

   public func requestObject<ResponseBodyType: Decodable>(
      method: HTTPMethod,
      path: String,
      body: Body? = nil,
      extraHeaders: [String: String] = [:],
      extraQueryItems: [URLQueryItem] = [],
      errorContext: String? = nil
   ) async throws(RequestError) -> ResponseBodyType {
      let responseData = try await self.requestData(method: method, path: path, body: body, extraHeaders: extraHeaders, extraQueryItems: extraQueryItems)

      do {
         return try self.jsonDecoder.decode(ResponseBodyType.self, from: responseData)
      } catch {
         throw .failedToDecodeSuccessBody(error, self.errorContext(requestContext: errorContext))
      }
   }

   @discardableResult
   public func requestData(
      method: HTTPMethod,
      path: String,
      body: Body? = nil,
      extraHeaders: [String: String] = [:],
      extraQueryItems: [URLQueryItem] = [],
      errorContext: String? = nil
   ) async throws(RequestError) -> Data {
      let url = self.baseURL
         .appending(path: path)
         .appending(queryItems: self.baseQueryItems + extraQueryItems)

      var request = URLRequest(url: url)
      request.httpMethod = method.rawValue

      for (field, value) in self.baseHeaders.merging(extraHeaders, uniquingKeysWith: { $1 }) {
         request.setValue(value, forHTTPHeaderField: field)
      }

      if let body {
         do {
            request.httpBody = try body.httpData()
         } catch {
            throw RequestError.failedToEncodeBody(error, self.errorContext(requestContext: errorContext))
         }

         request.setValue(body.contentType, forHTTPHeaderField: "Content-Type")
      }

      request.setValue("application/json", forHTTPHeaderField: "Accept")

      let (data, response) = try await self.performRequest(request, errorContext: errorContext)
      return try await self.handle(data: data, response: response, for: request, errorContext: errorContext)
   }

   private func errorContext(requestContext: String?) -> String? {
      let context = [self.baseErrorContext, requestContext].compactMap { $0 }.joined(separator: "->")
      guard !context.isEmpty else { return nil }
      return context
   }

   private func performRequest(_ request: URLRequest, errorContext: String?) async throws(RequestError) -> (Data, URLResponse) {
      self.logRequestIfDebug(request)

      let data: Data
      let response: URLResponse
      do {
         (data, response) = try await URLSession.shared.data(for: request)
      } catch {
         throw RequestError.failedToLoadData(error, self.errorContext(requestContext: errorContext))
      }

      self.logResponseIfDebug(response, data: data)
      return (data, response)
   }

   private func handle(data: Data, response: URLResponse, for request: URLRequest, errorContext: String?, attempt: Int = 1) async throws(RequestError) -> Data {
      guard let httpResponse = response as? HTTPURLResponse else {
         throw .unexpectedResponseType(response, self.errorContext(requestContext: errorContext))
      }

      switch httpResponse.statusCode {
      case 200..<300:
         return data

      case 429:
         guard attempt < 5 else  { fallthrough }

         #if DEBUG
         print("Received Status Code 429 'Too Many Requests'. Retrying in \(attempt) second(s)...")
         #endif

         try? await Task.sleep(for: .seconds(attempt))

         let (newData, newResponse) = try await self.performRequest(request, errorContext: errorContext)
         return try await self.handle(data: newData, response: newResponse, for: request, errorContext: errorContext, attempt: attempt + 1)

      case 400..<500:
         guard !data.isEmpty else {
            throw .clientError("Unexpected status code \(httpResponse.statusCode) without a response body.", self.errorContext(requestContext: errorContext))
         }

         let clientErrorMessage: String
         do {
            clientErrorMessage = try self.errorBodyToMessage(data)
         } catch {
            throw .failedToDecodeClientErrorBody(error, self.errorContext(requestContext: errorContext))
         }
         throw .clientError(clientErrorMessage, self.errorContext(requestContext: errorContext))

      default:
         throw .unexpectedStatusCode(httpResponse.statusCode, self.errorContext(requestContext: errorContext))
      }
   }

   private func logRequestIfDebug(_ request: URLRequest) {
      #if DEBUG
      var requestBodyString: String?
      if let bodyData = request.httpBody {
         requestBodyString = String(data: bodyData, encoding: .utf8)
      }

      print("[\(self)] Sending \(request.httpMethod!) request to '\(request.url!)': \(request)\n\nHeaders:\n\(request.allHTTPHeaderFields ?? [:])\n\nBody:\n\(requestBodyString ?? "No body")")
      #endif
   }

   private func logResponseIfDebug(_ response: URLResponse, data: Data?) {
      #if DEBUG
      var responseBodyString: String?
      if let data = data {
         responseBodyString = String(data: data, encoding: .utf8)
      }

      print("[\(self)] Received response & body from '\(response.url!)': \(response)\n\nResponse headers:\n\((response as? HTTPURLResponse)?.allHeaderFields ?? [:])\n\nResponse body:\n\(responseBodyString ?? "No body")")
      #endif
   }
}