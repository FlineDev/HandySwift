#if canImport(OSLog)
   import Foundation
   import OSLog

   #if canImport(FoundationNetworking)
      import FoundationNetworking
   #endif

   /// A plugin for debugging HTTP responses using OSLog structured logging.
   ///
   /// This plugin logs comprehensive response information including status code, headers, and body content
   /// using the modern OSLog framework for structured, searchable logging in apps.
   /// It's designed as a debugging tool and should only be used temporarily during development.
   ///
   /// ## Usage
   ///
   /// Add to your RESTClient for debugging:
   ///
   /// ```swift
   /// let client = RESTClient(
   ///     baseURL: URL(string: "https://api.example.com")!,
   ///     responsePlugins: [LogResponsePlugin()],  // debugOnly: true, redactAuthHeaders: true by default
   ///     errorBodyToMessage: { _ in "Error" }
   /// )
   /// ```
   ///
   /// Both `debugOnly` and `redactAuthHeaders` default to `true` for security. You can disable these built-in protections if needed:
   ///
   /// ```swift
   /// // Default behavior (recommended)
   /// LogResponsePlugin()  // debugOnly: true, redactAuthHeaders: true
   ///
   /// // Disable debugOnly to log in production (discouraged)
   /// LogResponsePlugin(debugOnly: false)
   ///
   /// // Disable redactAuthHeaders for debugging auth issues (use carefully)
   /// LogResponsePlugin(redactAuthHeaders: false)
   /// ```
   ///
   /// ## Log Output
   ///
   /// Logs are sent to the unified logging system with subsystem "RESTClient" and category "responses".
   /// Use Console.app or Instruments to view structured logs with searchable metadata.
   ///
   /// Example log entry:
   /// ```
   /// [RESTClient] Response 200 from 'https://api.example.com/v1/users/123'
   /// Headers: Content-Type=application/json, Set-Cookie=[redacted]
   /// Body: {"id": 123, "name": "John Doe", "email": "john@example.com"}
   /// ```
   ///
   /// - Note: By default, logging only occurs in DEBUG builds and authentication headers are redacted for security.
   /// - Important: The plugin is safe to leave in your code with default settings thanks to `debugOnly` protection.
   /// - Important: For server-side Swift (Vapor), use ``PrintResponsePlugin`` instead as OSLog is not available on Linux.
   @available(iOS 16, macOS 13, tvOS 16, watchOS 9, *)
   public struct LogResponsePlugin: RESTClient.ResponsePlugin {
      /// Whether logging should only occur in DEBUG builds.
      ///
      /// When `true` (default), responses are only logged in DEBUG builds.
      /// When `false`, responses are logged in both DEBUG and release builds (not recommended for production).
      public let debugOnly: Bool

      /// Whether to redact authentication headers in output.
      ///
      /// When `true` (default), authentication headers like Authorization and Set-Cookie are replaced with "[redacted]" for security.
      /// When `false`, the full header value is shown (use carefully for debugging auth issues).
      public let redactAuthHeaders: Bool

      /// The logger instance used for structured logging.
      private let logger = Logger(subsystem: "RESTClient", category: "responses")

      /// Creates a new log response plugin.
      ///
      /// - Parameters:
      ///   - debugOnly: Whether logging should only occur in DEBUG builds. Defaults to `true`.
      ///   - redactAuthHeaders: Whether to redact authentication headers. Defaults to `true`.
      public init(debugOnly: Bool = true, redactAuthHeaders: Bool = true) {
         self.debugOnly = debugOnly
         self.redactAuthHeaders = redactAuthHeaders
      }

      /// Applies the plugin to the response, logging response details if conditions are met.
      ///
      /// This method is called automatically by RESTClient after receiving the response.
      /// The response and data are passed through unchanged.
      ///
      /// - Parameters:
      ///   - response: The HTTPURLResponse to potentially log.
      ///   - data: The response body data to potentially log.
      /// - Throws: Does not throw errors, but passes through any errors from the response processing.
      public func apply(to response: inout HTTPURLResponse, data: inout Data) throws {
         if self.debugOnly {
            #if DEBUG
               self.logResponse(response, data: data)
            #endif
         } else {
            self.logResponse(response, data: data)
         }
      }

      /// Logs detailed response information using OSLog.
      ///
      /// - Parameters:
      ///   - response: The HTTPURLResponse to log details for.
      ///   - data: The response body data to log.
      private func logResponse(_ response: HTTPURLResponse, data: Data) {
         let statusCode = response.statusCode
         let url = response.url?.absoluteString ?? "Unknown URL"

         // Format headers for logging
         let headers = response.allHeaderFields
            .compactMapValues { "\($0)" }
            .sorted { "\($0.key)" < "\($1.key)" }
            .map { "\($0.key)=\(self.shouldRedactHeader("\($0.key)") ? "[redacted]" : $0.value)" }
            .joined(separator: ", ")

         // Format body for logging
         var bodyString = "No body"
         if !data.isEmpty,
            let body = String(data: data, encoding: .utf8)
         {
            bodyString = body
         }

         // Log with structured data
         self.logger.info(
            "Response \(statusCode, privacy: .public) from '\(url, privacy: .public)'"
         )
         self.logger.debug("Headers: \(headers, privacy: .private)")
         self.logger.debug("Body: \(bodyString, privacy: .private)")
      }

      /// Determines whether a header should be redacted for security.
      ///
      /// - Parameter headerName: The header name to check.
      /// - Returns: `true` if the header should be redacted when `redactAuthHeaders` is enabled.
      private func shouldRedactHeader(_ headerName: String) -> Bool {
         guard self.redactAuthHeaders else { return false }

         let lowercasedName = headerName.lowercased()

         // Exact header name matches
         let exactMatches = [
            "authorization", "cookie", "set-cookie", "x-api-key", "x-auth-token",
            "x-access-token", "bearer", "apikey", "api-key", "access-token",
            "refresh-token", "jwt", "session-token", "csrf-token", "x-csrf-token", "x-session-id",
         ]

         // Substring patterns that indicate sensitive content
         let sensitivePatterns = ["password", "secret", "token"]

         return exactMatches.contains(lowercasedName) || sensitivePatterns.contains { lowercasedName.contains($0) }
      }
   }
#endif
