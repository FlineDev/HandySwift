import Foundation

extension StringProtocol {
   /// Returns a variation with the first character uppercased.
   public var firstUppercased: String { self.prefix(1).uppercased() + self.dropFirst() }

   /// Returns a variation with the first character capitalized.
   public var firstCapitalized: String { self.prefix(1).capitalized + self.dropFirst() }

   /// Returns a variation with the first character lowercased.
   public var firstLowercased: String { self.prefix(1).lowercased() + self.dropFirst() }
}
