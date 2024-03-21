#if canImport(CryptoKit)
import Foundation
import CryptoKit

@available(iOS 13, macOS 10.15, tvOS 13, visionOS 1, watchOS 6, *)
extension SymmetricKey {
   /// Returns a Base64-encoded string representation of the symmetric key.
   ///
   /// - Returns: A Base64-encoded string representation of the symmetric key.
   public var base64EncodedString: String {
      withUnsafeBytes { Data($0).base64EncodedString() }
   }

   /// Initializes a symmetric key from a Base64-encoded string.
   ///
   /// - Parameter base64Encoded: The Base64-encoded string representing the symmetric key.
   /// - Returns: A symmetric key initialized from the Base64-encoded string, or `nil` if the input string is invalid.
   public init?(base64Encoded: String) {
      guard let data = Data(base64Encoded: base64Encoded) else { return nil }
      self.init(data: data)
   }
}
#endif
