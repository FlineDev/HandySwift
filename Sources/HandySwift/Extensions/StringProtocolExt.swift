import Foundation

extension StringProtocol {
   /// Returns a variation of the string with the first character uppercased.
   /// This is useful for formatting text that needs to start with a capital letter, such as titles or names, while preserving the case of the rest of the string.
   ///
   /// Example:
   /// ```swift
   /// let exampleString = "hello World"
   /// print(exampleString.firstUppercased) // Hello World
   /// ```
   ///
   /// - Returns: A string with the first character converted to uppercase.
   public var firstUppercased: String { self.prefix(1).uppercased() + self.dropFirst() }

   /// Returns a variation of the string with the first character lowercased.
   /// This can be useful in scenarios where a string starts with an uppercase letter but needs to be integrated into a sentence or phrase seamlessly.
   ///
   /// Example:
   /// ```swift
   /// let exampleString = "Hello world"
   /// print(exampleString.firstLowercased) // hello world
   /// ```
   ///
   /// - Returns: A string with the first character converted to lowercase and the rest unchanged.
   public var firstLowercased: String { self.prefix(1).lowercased() + self.dropFirst() }
}

// - MARK: Migration
extension StringProtocol {
   @available(*, unavailable, renamed: "firstUppercased")
   public var firstCapitalized: String { fatalError() }
}
