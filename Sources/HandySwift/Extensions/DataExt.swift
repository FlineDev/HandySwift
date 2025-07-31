#if canImport(CryptoKit)
   import CryptoKit
   import Foundation

   extension Data {
      /// Encrypts this plain `Data` using AES.GCM with the provided key.
      /// This method is useful for encrypting data before securely storing or transmitting it.
      /// Ensure that the `SymmetricKey` used for encryption is securely managed and stored.
      ///
      /// Example:
      /// ```swift
      /// let key = SymmetricKey(size: .bits256)
      /// let plainData = "Harry Potter is a 🧙".data(using: .utf8)!
      /// do {
      ///     let encryptedData = try plainData.encrypted(key: key)
      ///     // Use encryptedData as needed
      /// } catch {
      ///     print("Encryption failed: \(error)")
      /// }
      /// ```
      ///
      /// - Parameters:
      ///   - key: The symmetric key to use for encryption.
      /// - Returns: The encrypted `Data`.
      /// - Throws: An error if encryption fails.
      /// - Note: Available on iOS 13, macOS 10.15, tvOS 13, visionOS 1, watchOS 6, and later.
      @available(iOS 13, macOS 10.15, tvOS 13, visionOS 1, watchOS 6, *)
      public func encrypted(key: SymmetricKey) throws -> Data {
         try AES.GCM.seal(self, using: key).combined!
      }

      /// Decrypts this encrypted data using AES.GCM with the provided key.
      /// This method is crucial for converting encrypted data back to its original form securely.
      /// Ensure the `SymmetricKey` used matches the one used for encryption.
      ///
      /// Example:
      /// ```swift
      /// let key = SymmetricKey(size: .bits256)
      /// // Assuming encryptedData is the Data we previously encrypted
      /// do {
      ///     let decryptedData = try encryptedData.decrypted(key: key)
      ///     let decryptedString = String(data: decryptedData, encoding: .utf8)!
      ///     // Use decryptedString or decryptedData as needed
      /// } catch {
      ///     print("Decryption failed: \(error)")
      /// }
      /// ```
      ///
      /// - Parameters:
      ///   - key: The symmetric key to use for decryption.
      /// - Returns: The decrypted `Data`.
      /// - Throws: An error if decryption fails.
      /// - Note: Available on iOS 13, macOS 10.15, tvOS 13, visionOS 1, watchOS 6, and later.
      @available(iOS 13, macOS 10.15, tvOS 13, visionOS 1, watchOS 6, *)
      public func decrypted(key: SymmetricKey) throws -> Data {
         let sealedBox = try AES.GCM.SealedBox(combined: self)
         return try AES.GCM.open(sealedBox, using: key)
      }
   }
#endif
