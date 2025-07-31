#if canImport(CryptoKit)
   import Foundation
   import CryptoKit

   @available(iOS 13, macOS 10.15, tvOS 13, visionOS 1, watchOS 6, *)
   extension SymmetricKey {
      /// Returns a Base64-encoded string representation of the symmetric key. This can be useful for storing the key in a format that can be easily transmitted or stored.
      ///
      /// Example:
      /// ```swift
      /// let key = SymmetricKey(size: .bits256)
      /// let base64String = key.base64EncodedString
      /// // Now `base64String` can be stored or transmitted, and later used to recreate the SymmetricKey.
      /// ```
      ///
      /// - Returns: A Base64-encoded string representation of the symmetric key.
      public var base64EncodedString: String {
         withUnsafeBytes { Data($0).base64EncodedString() }
      }

      /// Initializes a symmetric key from a Base64-encoded string. This is particularly useful for reconstructing a symmetric key from a stored or transmitted Base64-encoded string.
      ///
      /// Example:
      /// ```swift
      /// let base64String = "your_base64_encoded_string_here"
      /// if let key = SymmetricKey(base64Encoded: base64String) {
      ///     // Use `key` here.
      /// } else {
      ///     // Handle the error: the provided string was not a valid Base64-encoded SymmetricKey.
      /// }
      /// ```
      ///
      /// - Parameter base64Encoded: The Base64-encoded string representing the symmetric key.
      /// - Returns: A symmetric key initialized from the Base64-encoded string, or `nil` if the input string is invalid.
      public init?(base64Encoded: String) {
         guard let data = Data(base64Encoded: base64Encoded) else { return nil }
         self.init(data: data)
      }
   }
#endif
