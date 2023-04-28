#if canImport(CryptoKit)
import CryptoKit
import Foundation

extension Data {
  /// Encrypts this plain `Data` with the given key using AES.GCM and returns the encrypted data.
  @available(macOS 10.15, iOS 13, watchOS 6, tvOS 13, *)
  public func encrypted(key: SymmetricKey) throws -> Data {
    try AES.GCM.seal(self, using: key).combined!
  }

  /// Decrypts this encrypted data with the given key using AES.GCM and returns the decrypted `Data`.
  @available(macOS 10.15, iOS 13, watchOS 6, tvOS 13, *)
  public func decrypted(key: SymmetricKey) throws -> Data {
    let sealedBox = try AES.GCM.SealedBox(combined: self)
    return try AES.GCM.open(sealedBox, using: key)
  }
}
#endif
