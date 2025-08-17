import Foundation

#if canImport(FoundationNetworking)
   import FoundationNetworking
#endif

/// A plugin for debugging HTTP requests by printing request details to the console.
///
/// This plugin prints comprehensive request information including URL, HTTP method, headers, and body content.
/// It's designed as a debugging tool and should only be used temporarily during development.
///
/// ## Usage
///
/// Add to your RESTClient for debugging:
///
/// ```swift
/// let client = RESTClient(
///     baseURL: URL(string: "https://api.example.com")!,
///     requestPlugins: [PrintRequestPlugin()],  // debugOnly: true, redactAuthHeaders: true by default
///     errorBodyToMessage: { _ in "Error" }
/// )
/// ```
///
/// Both `debugOnly` and `redactAuthHeaders` default to `true` for security. You can disable these built-in protections if needed:
///
/// ```swift
/// // Default behavior (recommended)
/// PrintRequestPlugin()  // debugOnly: true, redactAuthHeaders: true
///
/// // Disable debugOnly to log in production (discouraged)
/// PrintRequestPlugin(debugOnly: false)
///
/// // Disable redactAuthHeaders for debugging auth issues (use carefully)
/// PrintRequestPlugin(redactAuthHeaders: false)
/// ```
///
/// ## Output Example
///
/// ```
/// [RESTClient] Sending POST request to 'https://api.example.com/v1/users'
///
/// Headers:
///   Authorization: Bearer [redacted]
///   Content-Type: application/json
///   User-Agent: MyApp/1.0
///
/// Body:
/// {
///   "name": "John Doe",
///   "email": "john@example.com"
/// }
/// ```
///
/// - Note: By default, logging only occurs in DEBUG builds and authentication headers are redacted for security.
/// - Important: The plugin is safe to leave in your code with default settings thanks to `debugOnly` protection.
@available(iOS 16, macOS 13, tvOS 16, watchOS 9, *)
public struct PrintRequestPlugin: RESTClient.RequestPlugin {
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

   /// Creates a new print request plugin.
   ///
   /// - Parameters:
   ///   - debugOnly: Whether logging should only occur in DEBUG builds. Defaults to `true`.
   ///   - redactAuthHeaders: Whether to redact authentication headers. Defaults to `true`.
   public init(debugOnly: Bool = true, redactAuthHeaders: Bool = true) {
      self.debugOnly = debugOnly
      self.redactAuthHeaders = redactAuthHeaders
   }

   /// Applies the plugin to the request, printing request details if conditions are met.
   ///
   /// This method is called automatically by RESTClient before sending the request.
   ///
   /// - Parameter request: The URLRequest to potentially log and pass through unchanged.
   public func apply(to request: inout URLRequest) {
      if self.debugOnly {
         #if DEBUG
            self.printRequest(request)
         #endif
      } else {
         self.printRequest(request)
      }
   }

   /// Prints detailed request information to the console.
   ///
   /// - Parameter request: The URLRequest to print details for.
   private func printRequest(_ request: URLRequest) {
      var requestBodyString: String?
      if let bodyData = request.httpBody {
         requestBodyString = String(data: bodyData, encoding: .utf8)
      }

      // Clean headers formatting - sorted alphabetically for consistency
      let cleanHeaders = (request.allHTTPHeaderFields ?? [:])
         .sorted { $0.key < $1.key }
         .map { "  \($0.key): \(self.shouldRedactHeader($0.key) ? "[redacted]" : $0.value)" }
         .joined(separator: "\n")
      let headersString = cleanHeaders.isEmpty ? "  (none)" : "\n\(cleanHeaders)"

      print(
         "[RESTClient] Sending \(request.httpMethod!) request to '\(request.url!)'\n\nHeaders:\(headersString)\n\nBody:\n\(requestBodyString ?? "No body")"
      )
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
