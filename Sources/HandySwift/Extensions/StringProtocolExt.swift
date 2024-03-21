import Foundation

extension StringProtocol {
   /// Returns a variation of the string with the first character uppercased.
   ///
   /// - Returns: A string with the first character converted to uppercase.
   public var firstUppercased: String { self.prefix(1).uppercased() + self.dropFirst() }
   
   /// Returns a variation of the string with the first character capitalized.
   ///
   /// - Returns: A string with the first character converted to uppercase and the rest unchanged.
   public var firstCapitalized: String { self.prefix(1).capitalized + self.dropFirst() }
   
   /// Returns a variation of the string with the first character lowercased.
   ///
   /// - Returns: A string with the first character converted to lowercase and the rest unchanged.
   public var firstLowercased: String { self.prefix(1).lowercased() + self.dropFirst() }
}
