//
//  Regex.swift
//  HandySwift
//
//  Created by Frederick Pietschmann on 19.03.18.
//  Copyright © 2018 Flinesoft. All rights reserved.
//
//  Originally from: https://github.com/sharplet/Regex (modified to remove some weight).

// TODO: Document

import Foundation

public struct Regex {
    // MARK: - Properties
    private let regularExpression: NSRegularExpression

    // MARK: - Initializers
    /// Create a `Regex` based on a pattern string.
    ///
    /// If `pattern` is not a valid regular expression, an error is thrown
    /// describing the failure.
    ///
    /// - parameters:
    ///     - pattern: A pattern string describing the regex.
    ///     - options: Configure regular expression matching options.
    ///       For details, see `Regex.Options`.
    ///
    /// - throws: A value of `ErrorType` describing the invalid regular expression.
    public init(_  pattern: String, options: Options = []) throws {
        regularExpression = try NSRegularExpression(
            pattern: pattern,
            options: options.toNSRegularExpressionOptions()
        )
    }

    // MARK: - Methods: Matching
    /// Returns `true` if the regex matches `string`, otherwise returns `false`.
    ///
    /// - parameter string: The string to test.
    ///
    /// - returns: `true` if the regular expression matches, otherwise `false`.
    public func matches(_ string: String) -> Bool {
        return firstMatch(in: string) != nil
    }

    /// If the regex matches `string`, returns a `Match` describing the
    /// first matched string and any captures. If there are no matches, returns
    /// `nil`.
    ///
    /// - parameter string: The string to match against.
    ///
    /// - returns: An optional `Match` describing the first match, or `nil`.
    ///
    /// - note: If the match is successful, the result is also stored in `Regex.lastMatch`.
    public func firstMatch(in string: String) -> Match? {
        let match = regularExpression
            .firstMatch(in: string, options: [], range: NSRange(location: 0, length: string.utf16.count))
            .map { Match(result: $0, in: string) }
        return match
    }

    /// If the regex matches `string`, returns an array of `Match`, describing
    /// every match inside `string`. If there are no matches, returns an empty
    /// array.
    ///
    /// - parameter string: The string to match against.
    ///
    /// - returns: An array of `Match` describing every match in `string`.
    ///
    /// - note: If there is at least one match, the first is stored in `Regex.lastMatch`.
    public func matches(in string: String) -> [Match] {
        let matches = regularExpression
            .matches(in: string, options: [], range: NSRange(location: 0, length: string.utf16.count))
            .map { Match(result: $0, in: string) }
        return matches
    }

    // MARK: Replacing
    /// Returns a new string where each substring matched by `regex` is replaced
    /// with `template`.
    ///
    /// The template string may be a literal string, or include template variables:
    /// the variable `$0` will be replaced with the entire matched substring, `$1`
    /// with the first capture group, etc.
    ///
    /// For example, to include the literal string "$1" in the replacement string,
    /// you must escape the "$": `\$1`.
    ///
    /// - parameters:
    ///     - regex: A regular expression to match against `self`.
    ///     - template: A template string used to replace matches.
    ///     - count: The maximum count of matches to replace, beginning with the first match.
    ///
    /// - returns: A string with all matches of `regex` replaced by `template`.
    public func replacingMatches(in input: String, with template: String, count: Int? = nil) -> String {
        var output = input
        let matches = self.matches(in: input)
        let rangedMatches = Array(matches[0..<min(matches.count, count ?? .max)])
        for match in rangedMatches.reversed() {
            let replacement = match.string(applyingTemplate: template, withRegex: self)
            output.replaceSubrange(match.range, with: replacement)
        }

        return output
    }
}

// MARK: - ExpressibleByStringLiteral
extension Regex: ExpressibleByStringLiteral {
    public init(stringLiteral value: String) {
        do {
            try self.init(value)
        } catch {
            preconditionFailure("Not a valid regex: \(value)")
        }
    }
}

// MARK: - CustomStringConvertible
extension Regex: CustomStringConvertible {
    public var description: String {
        return "Regex(\(regularExpression.pattern))"
    }
}

// MARK: - Equatable
extension Regex: Equatable {
    public static func == (lhs: Regex, rhs: Regex) -> Bool {
        return lhs.regularExpression == rhs.regularExpression
    }
}

// MARK: - Hashable
extension Regex: Hashable {
    public var hashValue: Int {
        return regularExpression.hashValue
    }
}

// MARK: - Options
extension Regex {
    /// `Options` defines alternate behaviours of regular expressions when matching.
    public struct Options: OptionSet {
        // MARK: Properties
        /// Ignores the case of letters when matching.
        public static let ignoreCase = Options(rawValue: 1)

        /// Ignore any metacharacters in the pattern, treating every character as
        /// a literal.
        public static let ignoreMetacharacters = Options(rawValue: 1 << 1)

        /// By default, "^" matches the beginning of the string and "$" matches the
        /// end of the string, ignoring any newlines. With this option, "^" will
        /// the beginning of each line, and "$" will match the end of each line.
        public static let anchorsMatchLines = Options(rawValue: 1 << 2)

        /// Usually, "." matches all characters except newlines (\n). Using this
        /// this options will allow "." to match newLines
        public static let dotMatchesLineSeparators = Options(rawValue: 1 << 3)

        public let rawValue: Int

        // MARK: Initializers
        public init(rawValue: Int) {
            self.rawValue = rawValue
        }

        // MARK: Methods
        /// Transform an instance of `Regex.Options` into the equivalent `NSRegularExpression.Options`.
        ///
        /// - returns: The equivalent `NSRegularExpression.Options`.
        func toNSRegularExpressionOptions() -> NSRegularExpression.Options {
            var options = NSRegularExpression.Options()
            if contains(.ignoreCase) { options.insert(.caseInsensitive) }
            if contains(.ignoreMetacharacters) { options.insert(.ignoreMetacharacters) }
            if contains(.anchorsMatchLines) { options.insert(.anchorsMatchLines) }
            if contains(.dotMatchesLineSeparators) { options.insert(.dotMatchesLineSeparators) }
            return options
        }
    }
}

// MARK: - Match
extension Regex {
    /// A `Match` encapsulates the result of a single match in a string,
    /// providing access to the matched string, as well as any capture groups within
    /// that string.
    public class Match {
        // MARK: Properties
        /// The entire matched string.
        public lazy var string: String = {
            return String(describing: self.baseString[self.range])
        }()

        /// The range of the matched string.
        public lazy var range: Range<String.Index> = {
            return Range(self.result.range, in: self.baseString)!
        }()

        /// The matching string for each capture group in the regular expression
        /// (if any).
        ///
        /// **Note:** Usually if the match was successful, the captures will by
        /// definition be non-nil. However if a given capture group is optional, the
        /// captured string may also be nil, depending on the particular string that
        /// is being matched against.
        ///
        /// Example:
        ///
        ///     let regex = Regex("(a)?(b)")
        ///
        ///     regex.matches(in: "ab")first?.captures // [Optional("a"), Optional("b")]
        ///     regex.matches(in: "b").first?.captures // [nil, Optional("b")]
        public lazy var captures: [String?] = {
            let captureRanges = stride(from: 0, to: self.result.numberOfRanges, by: 1)
                .map(self.result.range)
                .dropFirst()
                .map { [unowned self] in Range($0, in: self.baseString) }
            return captureRanges.map { [unowned self] captureRange in
                if let captureRange = captureRange {
                    return String(describing: self.baseString[captureRange])
                }

                return nil
            }
        }()

        public let result: NSTextCheckingResult
        private let baseString: String

        // MARK: - Initializers
        internal init(result: NSTextCheckingResult, in string: String) {
            self.result = result
            self.baseString = string
        }

        // MARK: - Methods
        public func string(applyingTemplate template: String, withRegex regex: Regex) -> String {
            let replacement = regex.regularExpression.replacementString(
                for: result,
                in: baseString,
                offset: 0,
                template: template
            )

            return replacement
        }
    }
}
