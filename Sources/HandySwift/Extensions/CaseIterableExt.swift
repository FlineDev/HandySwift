import Foundation

extension CaseIterable {
   public static var allCasesPrefixedByNil: [Self?] {
      [.none] + self.allCases.map(Optional.init)
   }

   public static var allCasesSuffixedByNil: [Self?] {
      self.allCases.map(Optional.init) + [.none]
   }
}
