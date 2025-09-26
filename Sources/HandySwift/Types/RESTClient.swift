import Foundation

#if canImport(FoundationNetworking)
   import FoundationNetworking
#endif

/// A client to consume a REST API. Uses JSON to encode/decode body data.
@available(iOS 16, macOS 13, tvOS 16, watchOS 9, *)
public final class RESTClient: Sendable {
   public enum APIError: Error, LocalizedError, Sendable {
      public typealias Context = String

      case responsePluginFailed(Error, Context?)
      case failedToEncodeBody(Error, Context?)
      case failedToLoadData(Error, Context?)
      case failedToDecodeSuccessBody(Error, Context?)
      case failedToDecodeClientErrorBody(Error, Context?)
      case clientError(String, Context?)
      case unexpectedResponseType(URLResponse, Context?)
      case unexpectedStatusCode(Int, Context?)

      public var errorDescription: String? {
         switch self {
         case .responsePluginFailed(let error, _):
            "\(self.errorContext) Response plugin failed: \(error.localizedDescription)"
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
         case .responsePluginFailed(_, let context), .failedToEncodeBody(_, let context), .failedToLoadData(_, let context),
            .failedToDecodeSuccessBody(_, let context), .failedToDecodeClientErrorBody(_, let context), .clientError(_, let context):
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
      case multipart([MultipartItem], requestID: UUID)

      var contentType: String {
         switch self {
         case .binary: "application/octet-stream"
         case .json: "application/json"
         case .string: "text/plain"
         case .form: "application/x-www-form-urlencoded"
         case .multipart(_, let requestID): "multipart/form-data; boundary=handy-swift-boundary-\(requestID.uuidString)"
         }
      }

      /// Creates a multipart body with a generated UUID for request identification.
      public static func multipart(_ items: [MultipartItem]) -> Body {
         .multipart(items, requestID: UUID())
      }

      func httpData(jsonEncoder: JSONEncoder) throws -> Data {
         switch self {
         case .binary(let data):
            return data

         case .json(let json):
            return try jsonEncoder.encode(json)

         case .string(let string):
            return Data(string.utf8)

         case .form(let queryItems):
            var urlComponents = URLComponents(string: "https://example.com")!
            urlComponents.queryItems = queryItems
            return Data(urlComponents.percentEncodedQuery!.utf8)

         case .multipart(let items, let requestID):
            let boundaryString = "handy-swift-boundary-\(requestID.uuidString)"
            var body = Data()

            for item in items {
               // Add boundary separator
               body.append(Data("--\(boundaryString)\r\n".utf8))

               // Add Content-Disposition header
               var contentDisposition = "Content-Disposition: form-data; name=\"\(item.name)\""

               switch item.value {
               case .text(let text):
                  body.append(Data("\(contentDisposition)\r\n\r\n".utf8))
                  body.append(Data(text.utf8))

               case .data(let data, let fileName, let mimeType):
                  if let fileName = fileName {
                     contentDisposition += "; filename=\"\(fileName)\""
                  }
                  body.append(Data("\(contentDisposition)\r\n".utf8))

                  if let mimeType = mimeType {
                     body.append(Data("Content-Type: \(mimeType)\r\n".utf8))
                  }

                  body.append(Data("\r\n".utf8))
                  body.append(data)

               case .json(let json):
                  body.append(Data("\(contentDisposition)\r\n".utf8))
                  body.append(Data("Content-Type: application/json\r\n\r\n".utf8))
                  let jsonData = try jsonEncoder.encode(json)
                  body.append(jsonData)
               }

               body.append(Data("\r\n".utf8))
            }

            // Add final boundary
            body.append(Data("--\(boundaryString)--\r\n".utf8))

            return body
         }
      }
   }

   /// A name-value pair for multipart/form-data requests, following the URLQueryItem pattern.
   /// Used to construct multipart request bodies in a type-safe, explorable way.
   ///
   /// Example usage:
   /// ```swift
   /// let multipartItems: [RESTClient.MultipartItem] = [
   ///     .init(name: "model", value: .text("gpt-image-1")),
   ///     .init(name: "prompt", value: .text("Generate a liquid glass icon")),
   ///     .init(name: "image", value: .data(imageData, fileName: "input.png", mimeType: "image/png"))
   /// ]
   /// ```
   public struct MultipartItem: Sendable {
      /// The name of the form field.
      public let name: String

      /// The value of the form field, which can be text, binary data, or JSON.
      public let value: MultipartValue

      /// Creates a new multipart item with the specified name and value.
      /// - Parameters:
      ///   - name: The name of the form field
      ///   - value: The value of the form field
      public init(name: String, value: MultipartValue) {
         self.name = name
         self.value = value
      }
   }

   /// The value types supported in multipart/form-data requests.
   public enum MultipartValue: Sendable {
      /// A plain text value.
      case text(String)

      /// Binary data with optional filename and MIME type.
      /// - Parameters:
      ///   - data: The binary data to include
      ///   - fileName: Optional filename for the uploaded file
      ///   - mimeType: Optional MIME type (e.g., "image/png", "application/json")
      case data(Data, fileName: String?, mimeType: String?)

      /// A JSON-encodable value that will be serialized to JSON.
      case json(Encodable & Sendable)
   }

   public protocol RequestPlugin: Sendable {
      func apply(to request: inout URLRequest)
   }

   public protocol ResponsePlugin: Sendable {
      func apply(to response: inout HTTPURLResponse, data: inout Data) throws
   }

   let baseURL: URL
   let baseHeaders: [String: String]
   let baseQueryItems: [URLQueryItem]
   let jsonEncoder: JSONEncoder
   let jsonDecoder: JSONDecoder
   let urlSession: URLSession
   let requestPlugins: [any RequestPlugin]
   let responsePlugins: [any ResponsePlugin]
   let baseErrorContext: String?
   let errorBodyToMessage: @Sendable (Data) throws -> String

   // no need to pass 'application/json' to `baseHeaders`, it'll automatically be added of a body is sent
   public init(
      baseURL: URL,
      baseHeaders: [String: String] = [:],
      baseQueryItems: [URLQueryItem] = [],
      jsonEncoder: JSONEncoder = .init(),
      jsonDecoder: JSONDecoder = .init(),
      urlSession: URLSession = .shared,
      requestPlugins: [any RequestPlugin] = [],
      responsePlugins: [any ResponsePlugin] = [],
      baseErrorContext: String? = nil,
      errorBodyToMessage: @Sendable @escaping (Data) throws -> String
   ) {
      self.baseURL = baseURL
      self.baseHeaders = baseHeaders
      self.baseQueryItems = baseQueryItems
      self.jsonEncoder = jsonEncoder
      self.jsonDecoder = jsonDecoder
      self.urlSession = urlSession
      self.requestPlugins = requestPlugins
      self.responsePlugins = responsePlugins
      self.baseErrorContext = baseErrorContext
      self.errorBodyToMessage = errorBodyToMessage
   }

   public func send(
      method: HTTPMethod,
      path: String,
      body: Body? = nil,
      extraHeaders: [String: String] = [:],
      extraQueryItems: [URLQueryItem] = [],
      errorContext: String? = nil
   ) async throws(APIError) {
      _ = try await self.fetchData(method: method, path: path, body: body, extraHeaders: extraHeaders, extraQueryItems: extraQueryItems)
   }

   public func fetchAndDecode<ResponseBodyType: Decodable>(
      method: HTTPMethod,
      path: String,
      body: Body? = nil,
      extraHeaders: [String: String] = [:],
      extraQueryItems: [URLQueryItem] = [],
      errorContext: String? = nil
   ) async throws(APIError) -> ResponseBodyType {
      let responseData = try await self.fetchData(
         method: method,
         path: path,
         body: body,
         extraHeaders: extraHeaders,
         extraQueryItems: extraQueryItems
      )

      do {
         return try self.jsonDecoder.decode(ResponseBodyType.self, from: responseData)
      } catch {
         throw .failedToDecodeSuccessBody(error, self.errorContext(requestContext: errorContext))
      }
   }

   public func fetchData(
      method: HTTPMethod,
      path: String,
      body: Body? = nil,
      extraHeaders: [String: String] = [:],
      extraQueryItems: [URLQueryItem] = [],
      errorContext: String? = nil
   ) async throws(APIError) -> Data {
      let allQueryItems = self.baseQueryItems + extraQueryItems
      var url = self.baseURL.appending(path: path)
      if !allQueryItems.isEmpty {
         url = url.appending(queryItems: allQueryItems)
      }

      var request = URLRequest(url: url)
      request.httpMethod = method.rawValue

      for (field, value) in self.baseHeaders.merging(extraHeaders, uniquingKeysWith: { $1 }) {
         request.setValue(value, forHTTPHeaderField: field)
      }

      if let body {
         do {
            request.httpBody = try body.httpData(jsonEncoder: self.jsonEncoder)
         } catch {
            throw APIError.failedToEncodeBody(error, self.errorContext(requestContext: errorContext))
         }

         request.setValue(body.contentType, forHTTPHeaderField: "Content-Type")
      }

      request.setValue("application/json", forHTTPHeaderField: "Accept")

      for plugin in self.requestPlugins {
         plugin.apply(to: &request)
      }

      let (data, response) = try await self.performRequest(request, errorContext: errorContext)
      return try await self.handle(data: data, response: response, for: request, errorContext: errorContext)
   }

   private func errorContext(requestContext: String?) -> String? {
      let context = [self.baseErrorContext, requestContext].compactMap { $0 }.joined(separator: "->")
      guard !context.isEmpty else { return nil }
      return context
   }

   private func performRequest(_ request: URLRequest, errorContext: String?) async throws(APIError) -> (Data, URLResponse) {
      let data: Data
      let response: URLResponse
      do {
         (data, response) = try await self.urlSession.data(for: request)
      } catch {
         throw APIError.failedToLoadData(error, self.errorContext(requestContext: errorContext))
      }

      return (data, response)
   }

   private func handle(data: Data, response: URLResponse, for request: URLRequest, errorContext: String?, attempt: Int = 1) async throws(APIError)
      -> Data
   {
      guard var httpResponse = response as? HTTPURLResponse else {
         throw .unexpectedResponseType(response, self.errorContext(requestContext: errorContext))
      }

      var data = data
      for responsePlugin in self.responsePlugins {
         do {
            try responsePlugin.apply(to: &httpResponse, data: &data)
         } catch {
            throw APIError.responsePluginFailed(error, self.errorContext(requestContext: errorContext))
         }
      }

      switch httpResponse.statusCode {
      case 200..<300:
         return data

      case 429:
         guard attempt < 5 else { fallthrough }

         var sleepSeconds: Double = Double(attempt)

         // respect the server retry-after(-ms) value if it exists, allowing values betwen 0.5-5 seconds
         if let retryAfterMillisecondsString = httpResponse.value(forHTTPHeaderField: "retry-after-ms"),
            let retryAfterMilliseconds = Double(retryAfterMillisecondsString)
         {
            sleepSeconds = max(0.5, min(retryAfterMilliseconds, 5))
         } else if let retryAfterString = httpResponse.value(forHTTPHeaderField: "retry-after"),
            let retryAfter = Double(retryAfterString)
         {
            sleepSeconds = max(0.5, min(retryAfter, 5))
         }

         #if DEBUG
            print("Received Status Code 429 'Too Many Requests'. Retrying in \(sleepSeconds) second(s)...")
         #endif

         try? await Task.sleep(for: .seconds(sleepSeconds))

         let (newData, newResponse) = try await self.performRequest(request, errorContext: errorContext)
         return try await self.handle(data: newData, response: newResponse, for: request, errorContext: errorContext, attempt: attempt + 1)

      case 400..<500:
         guard !data.isEmpty else {
            throw .clientError(
               "Unexpected status code \(httpResponse.statusCode) without a response body.",
               self.errorContext(requestContext: errorContext)
            )
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
}
