import Foundation

#if canImport(FoundationNetworking)
   import FoundationNetworking
#endif

/// A plugin for debugging HTTP responses by printing response details to the console.
///
/// This plugin prints comprehensive response information including status code, headers, and body content.
/// It's designed as a debugging tool and should only be used temporarily during development.
///
/// ## Usage
///
/// Add to your RESTClient for debugging:
///
/// ```swift
/// let client = RESTClient(
///     baseURL: URL(string: "https://api.example.com")!,
///     responsePlugins: [PrintResponsePlugin()],  // debugOnly: true, redactAPIKey: true by default
///     errorBodyToMessage: { _ in "Error" }
/// )
/// ```
///
/// Both `debugOnly` and `redactAPIKey` default to `true` for security. You can disable these built-in protections if needed:
///
/// ```swift
/// // Default behavior (recommended)
/// PrintResponsePlugin()  // debugOnly: true, redactAPIKey: true
///
/// // Disable debugOnly to log in production (discouraged)
/// PrintResponsePlugin(debugOnly: false)
///
/// // Disable redactAPIKey for debugging auth issues (use carefully)
/// PrintResponsePlugin(redactAPIKey: false)
/// ```
///
/// ## Output Example
///
/// ```
/// [RESTClient] Response 200 from 'https://api.example.com/v1/users/123'
///
/// Response headers:
///   Content-Type: application/json
///   Date: Wed, 08 Aug 2025 10:30:00 GMT
///   Server: nginx/1.18.0
///   Set-Cookie: session_token=[redacted]
///   X-Request-ID: req_abc123def456
///
/// Response body:
/// {
///   "id": 123,
///   "name": "John Doe",
///   "email": "john@example.com",
///   "created_at": "2023-08-01T10:30:00Z"
/// }
/// ```
///
/// - Note: By default, logging only occurs in DEBUG builds and API keys are redacted for security.
/// - Important: The plugin is safe to leave in your code with default settings thanks to `debugOnly` protection.
@available(iOS 16, macOS 13, tvOS 16, watchOS 9, *)
public struct PrintResponsePlugin: RESTClient.ResponsePlugin {
   /// Whether logging should only occur in DEBUG builds.
   ///
   /// When `true` (default), responses are only logged in DEBUG builds.
   /// When `false`, responses are logged in both DEBUG and release builds (not recommended for production).
   public let debugOnly: Bool

   /// Whether to redact API keys from sensitive headers in output.
   ///
   /// When `true` (default), sensitive headers like Authorization and Set-Cookie are replaced with "[redacted]" for security.
   /// When `false`, the full header value is shown (use carefully for debugging auth issues).
   public let redactAPIKey: Bool

   /// Creates a new print response plugin.
   ///
   /// - Parameters:
   ///   - debugOnly: Whether logging should only occur in DEBUG builds. Defaults to `true`.
   ///   - redactAPIKey: Whether to redact API keys from sensitive headers. Defaults to `true`.
   public init(debugOnly: Bool = true, redactAPIKey: Bool = true) {
      self.debugOnly = debugOnly
      self.redactAPIKey = redactAPIKey
   }

   /// Applies the plugin to the response, printing response details if conditions are met.
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
            self.printResponse(response, data: data)
         #endif
      } else {
         self.printResponse(response, data: data)
      }
   }

   /// Prints detailed response information to the console.
   ///
   /// - Parameters:
   ///   - response: The HTTPURLResponse to print details for.
   ///   - data: The response body data to print.
   private func printResponse(_ response: HTTPURLResponse, data: Data) {
      var responseBodyString: String?
      if !data.isEmpty {
         responseBodyString = String(data: data, encoding: .utf8)
      }

      // Clean headers formatting - sorted alphabetically for consistency, no AnyHashable wrappers
      var headersString = ""
      let cleanHeaders = response.allHeaderFields
         .compactMapValues { "\($0)" }
         .sorted { "\($0.key)" < "\($1.key)" }
         .map { "  \($0.key): \(self.shouldRedactHeader("\($0.key)") ? "[redacted]" : $0.value)" }
         .joined(separator: "\n")
      headersString = cleanHeaders.isEmpty ? "  (none)" : "\n\(cleanHeaders)"

      print(
         "[RESTClient] Response \(response.statusCode) from '\(response.url!)'\n\nResponse headers:\(headersString)\n\nResponse body:\n\(responseBodyString ?? "No body")"
      )
   }

   /// Determines whether a header should be redacted for security.
   ///
   /// - Parameter headerName: The header name to check.
   /// - Returns: `true` if the header should be redacted when `redactAPIKey` is enabled.
   private func shouldRedactHeader(_ headerName: String) -> Bool {
      guard self.redactAPIKey else { return false }

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
