// Copyright © 2015 Flinesoft. All rights reserved.

import Foundation
#if canImport(CryptoKit)
import CryptoKit
#endif

extension String {
  /// - Returns: `true` if contains any cahracters other than whitespace or newline characters, else `no`.
  public var isBlank: Bool { stripped().isEmpty }
  
  /// Returns a random character from the String.
  ///
  /// - Returns: A random character from the String or `nil` if empty.
  public var sample: Character? {
    isEmpty ? nil : self[index(startIndex, offsetBy: Int(randomBelow: count)!)]
  }
  
  /// Returns the range containing the full String.
  public var fullRange: Range<Index> {
    startIndex ..< endIndex
  }
  
  /// Returns the range as NSRange type for the full String.
  public var fullNSRange: NSRange {
    NSRange(fullRange, in: self)
  }
  
  /// Create new instance with random numeric/alphabetic/alphanumeric String of given length.
  ///
  /// - Parameters:
  ///   - randommWithLength:      The length of the random String to create.
  ///   - allowedCharactersType:  The allowed characters type, see enum `AllowedCharacters`.
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
    
    self.init(allowedCharsString.sample(size: length)!)
  }
  
  /// - Returns: The string stripped by whitespace and newline characters from beginning and end.
  public func stripped() -> String { trimmingCharacters(in: .whitespacesAndNewlines) }
  
  /// Returns a given number of random characters from the String.
  ///
  /// - Parameters:
  ///   - size: The number of random characters wanted.
  /// - Returns: A String with the given number of random characters or `nil` if empty.
  @inlinable
  public func sample(size: Int) -> String? {
    guard !isEmpty else { return nil }
    
    var sampleElements = String()
    size.times { sampleElements.append(sample!) }
    
    return sampleElements
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
    /// Allow all characters appearing within the specified String.
    case allCharactersIn(String)
  }
}

#if canImport(CryptoKit)
extension String {
  /// Encrypts this plain text `String` with the given key using AES.GCM and returns a base64 encoded representation of the encrypted data.
  @available(macOS 10.15, iOS 13, watchOS 6, tvOS 13, *)
  public func encrypted(key: SymmetricKey) throws -> String {
    let plainData = self.data(using: .utf8)!
    let encryptedData = try plainData.encrypted(key: key)
    return encryptedData.base64EncodedString()
  }
  
  /// Decrypts this base64 encoded representation of encrypted data with the given key using AES.GCM and returns the decrypted plain text `String`.
  @available(macOS 10.15, iOS 13, watchOS 6, tvOS 13, *)
  public func decrypted(key: SymmetricKey) throws -> String {
    let encryptedData = Data(base64Encoded: self)!
    let plainData = try encryptedData.decrypted(key: key)
    return String(data: plainData, encoding: .utf8)!
  }
}
#endif
