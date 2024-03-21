import Foundation
#if canImport(CryptoKit)
import CryptoKit
#endif

extension String {
   /// Checks if the string contains any characters other than whitespace or newline characters.
   ///
   /// - Returns: `true` if the string contains non-whitespace characters, `false` otherwise.
   public var isBlank: Bool { self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty }

   /// Returns the range containing the full string.
   ///
   /// - Returns: The range representing the full string.
   public var fullRange: Range<Index> {
      self.startIndex..<self.endIndex
   }

   /// Returns the range as NSRange type for the full string.
   ///
   /// - Returns: The NSRange representation of the full string range.
   public var fullNSRange: NSRange {
      NSRange(fullRange, in: self)
   }

   /// Creates a new instance with a random numeric/alphabetic/alphanumeric string of given length.
   ///
   /// - Parameters:
   ///   - randomWithLength: The length of the random string to create.
   ///   - allowedCharactersType: The type of allowed characters, see enum `AllowedCharacters`.
   public init(randomWithLength length: Int, allowedCharactersType: AllowedCharacters) {
      let allowedCharsString: String = {
         switch allowedCharactersType {
         case .numeric:
            return "0123456789"

         case .alphabetic:
            return "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"

         case .alphaNumeric:
            return "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"

         case let .allCharactersIn(allowedCharactersString):
            return allowedCharactersString
         }
      }()

      self.init(allowedCharsString.randomElements(count: length)!)
   }

   /// Returns a given number of random characters from the string.
   ///
   /// - Parameters:
   ///   - count: The number of random characters wanted.
   /// - Returns: A string with the given number of random characters or `nil` if empty.
   @inlinable
   public func randomElements(count: Int) -> String? {
      guard !self.isEmpty else { return nil }
      return String(count.timesMake { self.randomElement()! })
   }
}

extension String {
   /// The type of allowed characters.
   public enum AllowedCharacters {
      /// Allow all numbers from 0 to 9.
      case numeric
      /// Allow all alphabetic characters ignoring case.
      case alphabetic
      /// Allow both numbers and alphabetic characters ignoring case.
      case alphaNumeric
      /// Allow all characters appearing within the specified string.
      case allCharactersIn(String)
   }
}

#if canImport(CryptoKit)
extension String {
   /// Error types that may occur during cryptographic operations.
   public enum CryptingError: LocalizedError {
      case convertingStringToDataFailed
      case decryptingDataFailed
      case convertingDataToStringFailed

      public var errorDescription: String? {
         switch self {
         case .convertingDataToStringFailed:
            return "Converting Data to String failed."

         case .decryptingDataFailed:
            return "Decrypting Data failed."

         case .convertingStringToDataFailed:
            return "Converting String to Data failed."
         }
      }
   }

   /// Encrypts this plain text `String` with the given key using AES.GCM and returns a base64 encoded representation of the encrypted data.
   ///
   /// - Parameter key: The symmetric key used for encryption.
   /// - Returns: A base64 encoded representation of the encrypted data.
   /// - Throws: A `CryptingError` if encryption fails.
   @available(iOS 13, macOS 10.15, tvOS 13, visionOS 1, watchOS 6, *)
   public func encrypted(key: SymmetricKey) throws -> String {
      guard let plainData = self.data(using: .utf8) else {
         throw CryptingError.convertingStringToDataFailed
      }

      let encryptedData = try plainData.encrypted(key: key)
      return encryptedData.base64EncodedString()
   }

   /// Decrypts this base64 encoded representation of encrypted data with the given key using AES.GCM and returns the decrypted plain text `String`.
   ///
   /// - Parameter key: The symmetric key used for decryption.
   /// - Returns: The decrypted plain text `String`.
   /// - Throws: A `CryptingError` if decryption fails.
   @available(iOS 13, macOS 10.15, tvOS 13, visionOS 1, watchOS 6, *)
   public func decrypted(key: SymmetricKey) throws -> String {
      guard let encryptedData = Data(base64Encoded: self) else {
         throw CryptingError.decryptingDataFailed
      }

      let plainData = try encryptedData.decrypted(key: key)
      guard let plainString = String(data: plainData, encoding: .utf8) else {
         throw CryptingError.convertingDataToStringFailed
      }

      return plainString
   }
}
#endif

// MARK: Migration
extension String {
   @available(*, unavailable, renamed: "randomElement()")
   public var sample: Character? { fatalError() }

   @available(*, unavailable, renamed: "trimmingCharacters(in:)", message: "Pass `.whitespacesAndNewlines` to the functions `in` parameter for same behavior.")
   public func stripped() -> String { fatalError() }

   @available(*, unavailable, renamed: "randomElements(count:)")
   public func sample(size: Int) -> String? { fatalError() }
}
