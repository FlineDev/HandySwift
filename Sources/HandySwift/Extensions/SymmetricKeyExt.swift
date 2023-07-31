#if canImport(CryptoKit)
import Foundation
import CryptoKit

@available(macOS 10.15, iOS 13, watchOS 6, tvOS 13, *)
extension SymmetricKey {
   public var base64EncodedString: String {
      withUnsafeBytes { Data($0).base64EncodedString() }
   }

   public init?(
      base64Encoded: String
   ) {
      guard let data = Data(base64Encoded: base64Encoded) else { return nil }
      self.init(data: data)
   }
}
#endif
