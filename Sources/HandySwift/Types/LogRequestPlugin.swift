#if canImport(OSLog)
   import Foundation
   import OSLog

   #if canImport(FoundationNetworking)
      import FoundationNetworking
   #endif

   /// A plugin for debugging HTTP requests using OSLog structured logging.
   ///
   /// This plugin logs comprehensive request information including URL, HTTP method, headers, and body content
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
   ///     requestPlugins: [LogRequestPlugin()],  // debugOnly: true, redactAuthHeaders: true by default
   ///     errorBodyToMessage: { _ in "Error" }
   /// )
   /// ```
   ///
   /// Both `debugOnly` and `redactAuthHeaders` default to `true` for security. You can disable these built-in protections if needed:
   ///
   /// ```swift
   /// // Default behavior (recommended)
   /// LogRequestPlugin()  // debugOnly: true, redactAuthHeaders: true
   ///
   /// // Disable debugOnly to log in production (discouraged)
   /// LogRequestPlugin(debugOnly: false)
   ///
   /// // Disable redactAuthHeaders for debugging auth issues (use carefully)
   /// LogRequestPlugin(redactAuthHeaders: false)
   /// ```
   ///
   /// ## Log Output
   ///
   /// Logs are sent to the unified logging system with subsystem "RESTClient" and category "requests".
   /// Use Console.app or Instruments to view structured logs with searchable metadata.
   ///
   /// Example log entry:
   /// ```
   /// [RESTClient] Sending POST request to 'https://api.example.com/v1/users'
   /// Headers: Authorization=[redacted], Content-Type=application/json
   /// Body: {"name": "John Doe", "email": "john@example.com"}
   /// ```
   ///
   /// - Note: By default, logging only occurs in DEBUG builds and authentication headers are redacted for security.
   /// - Important: The plugin is safe to leave in your code with default settings thanks to `debugOnly` protection.
   /// - Important: For server-side Swift (Vapor), use ``PrintRequestPlugin`` instead as OSLog is not available on Linux.
   @available(iOS 16, macOS 13, tvOS 16, watchOS 9, *)
   public struct LogRequestPlugin: RESTClient.RequestPlugin {
      /// Whether logging should only occur in DEBUG builds.
      ///
      /// When `true` (default), requests are only logged in DEBUG builds.
      /// When `false`, requests are logged in both DEBUG and release builds (not recommended for production).
      public let debugOnly: Bool

      /// Whether to redact authentication headers in output.
      ///
      /// When `true` (default), authentication headers are replaced with "[redacted]" for security.
      /// When `false`, the full header value is shown (use carefully for debugging auth issues).
      public let redactAuthHeaders: Bool

      /// The logger instance used for structured logging.
      private let logger = Logger(subsystem: "RESTClient", category: "requests")

      /// Creates a new log request plugin.
      ///
      /// - Parameters:
      ///   - debugOnly: Whether logging should only occur in DEBUG builds. Defaults to `true`.
      ///   - redactAuthHeaders: Whether to redact authentication headers. Defaults to `true`.
      public init(debugOnly: Bool = true, redactAuthHeaders: Bool = true) {
         self.debugOnly = debugOnly
         self.redactAuthHeaders = redactAuthHeaders
      }

      /// Applies the plugin to the request, logging request details if conditions are met.
      ///
      /// This method is called automatically by RESTClient before sending the request.
      ///
      /// - Parameter request: The URLRequest to potentially log and pass through unchanged.
      public func apply(to request: inout URLRequest) {
         if self.debugOnly {
            #if DEBUG
               self.logRequest(request)
            #endif
         } else {
            self.logRequest(request)
         }
      }

      /// Logs detailed request information using OSLog.
      ///
      /// - Parameter request: The URLRequest to log details for.
      private func logRequest(_ request: URLRequest) {
         let method = request.httpMethod ?? "UNKNOWN"
         let url = request.url?.absoluteString ?? "Unknown URL"

         // Format headers for logging
         let headers = (request.allHTTPHeaderFields ?? [:])
            .sorted { $0.key < $1.key }
            .map { "\($0.key)=\(self.shouldRedactHeader($0.key) ? "[redacted]" : $0.value)" }
            .joined(separator: ", ")

         // Format body for logging
         var bodyString = "No body"
         if let bodyData = request.httpBody,
            let body = String(data: bodyData, encoding: .utf8)
         {
            bodyString = body
         }

         // Log with structured data
         self.logger.info(
            "Sending \(method, privacy: .public) request to '\(url, privacy: .public)'"
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
