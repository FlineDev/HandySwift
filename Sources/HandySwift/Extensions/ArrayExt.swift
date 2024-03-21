import Foundation

// MARK: Migration
extension Array {
   @available(*, unavailable, renamed: "sort(by:)", message: "Since SE-0372 shipped in Swift 5.8 `sort(by:)` is officially stable. Just remove the `stable` parameter.")
   public mutating func sort(by areInIncreasingOrder: @escaping (Element, Element) -> Bool, stable: Bool) { fatalError() }

   @available(*, unavailable, renamed: "sorted(by:)", message: "Since SE-0372 shipped in Swift 5.8 `sorted(by:)` is officially stable. Just remove the `stable` parameter.")
   public func sorted(by areInIncreasingOrder: @escaping (Element, Element) -> Bool, stable: Bool) -> [Element] { fatalError() }
}

extension Array where Element: Comparable {
   @available(*, unavailable, renamed: "sort()", message: "Since SE-0372 shipped in Swift 5.8 `sort()` is officially stable. Just remove the `stable` parameter.")
   public mutating func sort(stable: Bool) { fatalError() }

   @available(*, unavailable, renamed: "sorted()", message: "Since SE-0372 shipped in Swift 5.8 `sorted()` is officially stable. Just remove the `stable` parameter.")
   public func sorted(stable: Bool) -> [Element] { fatalError() }
}
