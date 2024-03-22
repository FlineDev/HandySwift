import Foundation
#if canImport(CryptoKit)
import CryptoKit
#endif

extension String {
   /// Checks if the string contains any characters other than whitespace or newline characters. 
   /// This can be useful for validating input fields where a non-empty value is required.
   ///
   /// Example:
   /// ```swift
   /// "  \t  ".isBlank // => true
   /// "Hello".isBlank // => false
   /// ```
   ///
   /// - Returns: `true` if the string contains non-whitespace characters, `false` otherwise.
   public var isBlank: Bool { self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty }

   /// Returns the range containing the full string. 
   /// Useful for operations that require a `Range<String.Index>`, such as modifications and substring extraction.
   ///
   /// Example:
   /// ```swift
   /// let unicodeString = "Hello composed unicode symbols! 👨‍👩‍👧‍👦👨‍👨‍👦‍👦👩‍👩‍👧‍👧"
   /// unicodeString[unicodeString.fullRange] // => same string
   /// ```
   ///
   /// - Returns: The range representing the full string.
   public var fullRange: Range<Index> {
      self.startIndex..<self.endIndex
   }

   /// Returns the range as NSRange type for the full string. 
   /// This is particularly useful when interacting with APIs that require NSRange, such as UIKit text manipulation.
   ///
   /// Example:
   /// ```swift
   /// let string = "Hello World!"
   /// let nsRange = string.fullNSRange // => NSRange representing the full string
   /// ```
   ///
   /// - Returns: The NSRange representation of the full string range.
   public var fullNSRange: NSRange {
      NSRange(fullRange, in: self)
   }

   /// Creates a new instance with a random numeric/alphabetic/alphanumeric string of given length. 
   /// This is useful for generating random identifiers, test data, or any scenario where random strings are needed.
   ///
   /// Examples:
   /// ```swift
   /// String(randomWithLength: 4, allowedCharactersType: .numeric) // => "8503"
   /// String(randomWithLength: 6, allowedCharactersType: .alphabetic) // => "ysTUzU"
   /// String(randomWithLength: 8, allowedCharactersType: .alphaNumeric) // => "2TgM5sUG"
   /// ```
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

   /// Returns a given number of random characters from the string. Useful for scenarios like sampling characters or generating substrings from a set of allowed characters.
   ///
   /// Example:
   /// ```swift
   /// let allowedChars = "abcdefghijklmnopqrstuvwxyz"
   /// let randomChars = allowedChars.randomElements(count: 5) // Example output: "xkqoi"
   /// ```
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
   /// This is used in conjunction with `init(randomWithLength:allowedCharactersType:)` to specify the characters that can be included in the random string.
   public enum AllowedCharacters {
      /// Allow all numbers from 0 to 9. Useful for numeric identifiers or pin codes.
      case numeric
      /// Allow all alphabetic characters ignoring case. Useful for textual data where numbers are not needed.
      case alphabetic
      /// Allow both numbers and alphabetic characters ignoring case. Useful for alphanumeric identifiers.
      case alphaNumeric
      /// Allow all characters appearing within the specified string. This gives you full control over the characters that can appear in the random string.
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
   /// This method is useful for securing sensitive information before storing or transmitting it.
   ///
   /// Example:
   /// ```swift
   /// let key = SymmetricKey(size: .bits256)
   /// let plainText = "Sensitive information"
   /// let encryptedString = try plainText.encrypted(key: key)
   /// print(encryptedString) // Encrypted base64 string
   /// ```
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
   /// This method allows the secure transmission or storage of sensitive information to be reversed, returning the original plain text.
   ///
   /// Example:
   /// ```swift
   /// let key = SymmetricKey(size: .bits256)
   /// let encryptedString = "Base64EncodedEncryptedString"
   /// let decryptedString = try encryptedString.decrypted(key: key)
   /// print(decryptedString) // Original sensitive information
   /// ```
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


// - MARK: Migration
extension String {
   @available(*, unavailable, renamed: "randomElement()")
   public var sample: Character? { fatalError() }

   @available(*, unavailable, renamed: "trimmingCharacters(in:)", message: "Pass `.whitespacesAndNewlines` to the functions `in` parameter for same behavior.")
   public func stripped() -> String { fatalError() }

   @available(*, unavailable, renamed: "randomElements(count:)")
   public func sample(size: Int) -> String? { fatalError() }
}
