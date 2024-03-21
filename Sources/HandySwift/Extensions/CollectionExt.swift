import Foundation

extension Collection {
   /// Returns the element at the specified index or `nil` if no element at the given index exists.
   @inlinable
   public subscript(safe index: Index) -> Element? {
      self.indices.contains(index) ? self[index] : nil
   }
}

extension Collection where Element: DivisibleArithmetic {
   /// Returns the average of all elements.
   @inlinable
   public func average() -> Element {
      self.sum() / Element(self.count)
   }
}

extension Collection where Element == Int {
   /// Returns the average of all elements as a Double value.
   @inlinable
   public func average<ReturnType: DivisibleArithmetic>() -> ReturnType {
      ReturnType(self.sum()) / ReturnType(self.count)
   }
}

// MARK: Migration
extension Collection {
   @available(*, unavailable, renamed: "subscript(safe:)")
   public subscript(try index: Index) -> Element? { fatalError() }
}
