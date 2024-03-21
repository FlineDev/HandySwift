#if canImport(CryptoKit)
import Foundation
import CryptoKit

@available(iOS 13, macOS 10.15, tvOS 13, visionOS 1, watchOS 6, *)
extension SymmetricKey {
   public var base64EncodedString: String {
      withUnsafeBytes { Data($0).base64EncodedString() }
   }

   public init?(base64Encoded: String) {
      guard let data = Data(base64Encoded: base64Encoded) else { return nil }
      self.init(data: data)
   }
}
#endif
