import Foundation

extension CaseIterable {
   /// Returns an array containing all cases of the conforming type, with `nil` prefixed.
   ///
   /// - Returns: An array of optional values including `nil` followed by all cases of the type.
   public static var allCasesPrefixedByNil: [Self?] {
      [.none] + self.allCases.map(Optional.init)
   }

   /// Returns an array containing all cases of the conforming type, with `nil` suffixed.
   ///
   /// - Returns: An array of optional values including all cases of the type followed by `nil`.
   public static var allCasesSuffixedByNil: [Self?] {
      self.allCases.map(Optional.init) + [.none]
   }
}
