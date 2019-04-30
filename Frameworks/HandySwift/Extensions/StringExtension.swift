//
//  Created by Cihat Gündüz on 26.12.15.
//  Copyright © 2015 Flinesoft. All rights reserved.
//

import Foundation

extension String {
    /// - Returns: `true` if contains any cahracters other than whitespace or newline characters, else `no`.
    public var isBlank: Bool { return stripped().isEmpty }

    /// Returns a random character from the String.
    ///
    /// - Returns: A random character from the String or `nil` if empty.
    public var sample: Character? {
        return isEmpty ? nil : self[index(startIndex, offsetBy: Int(randomBelow: count)!)]
    }

    /// Returns the range containing the full String.
    public var fullRange: Range<Index> {
        return startIndex ..< endIndex
    }

    /// Returns the range as NSRange type for the full String.
    public var fullNSRange: NSRange {
        return NSRange(fullRange, in: self)
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
    public func stripped() -> String { return trimmingCharacters(in: .whitespacesAndNewlines) }

    /// Returns a given number of random characters from the String.
    ///
    /// - Parameters:
    ///   - size: The number of random characters wanted.
    /// - Returns: A String with the given number of random characters or `nil` if empty.
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
