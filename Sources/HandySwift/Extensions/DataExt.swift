#if canImport(CryptoKit)
import CryptoKit
import Foundation

extension Data {
   /// Encrypts this plain `Data` using AES.GCM with the provided key.
   ///
   /// - Parameters:
   ///   - key: The symmetric key to use for encryption.
   /// - Returns: The encrypted `Data`.
   /// - Throws: An error if encryption fails.
   @available(iOS 13, macOS 10.15, tvOS 13, visionOS 1, watchOS 6, *)
   public func encrypted(key: SymmetricKey) throws -> Data {
      try AES.GCM.seal(self, using: key).combined!
   }

   /// Decrypts this encrypted data using AES.GCM with the provided key.
   ///
   /// - Parameters:
   ///   - key: The symmetric key to use for decryption.
   /// - Returns: The decrypted `Data`.
   /// - Throws: An error if decryption fails.
   @available(iOS 13, macOS 10.15, tvOS 13, visionOS 1, watchOS 6, *)
   public func decrypted(key: SymmetricKey) throws -> Data {
      let sealedBox = try AES.GCM.SealedBox(combined: self)
      return try AES.GCM.open(sealedBox, using: key)
   }
}
#endif
