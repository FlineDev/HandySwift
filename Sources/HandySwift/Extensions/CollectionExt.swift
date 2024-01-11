import Foundation

extension Collection {
   /// Returns an element with the specified index or nil if the element does not exist.
   ///
   /// - Parameters:
   ///   - try: The index of the element.
   @inlinable
   public subscript(try index: Index) -> Element? {
      indices.contains(index) ? self[index] : nil
   }
}

extension Sequence where Element: Numeric {
   /// Returns the sum of all elements.
   @inlinable
   public func sum() -> Element {
      reduce(0, +)
   }
}

extension Sequence {
   /// Returns the sum of all elements mapped to a numeric value.
   @inlinable
   public func sum<N: Numeric>(mapToNumeric: (Element) -> N) -> N {
      self.reduce(into: 0) { $0 += mapToNumeric($1) }
   }
}

extension Collection where Element: DivisibleArithmetic {
   /// Returns the average of all elements.
   @inlinable
   public func average() -> Element {
      sum() / Element(count)
   }
}

extension Collection where Element == Int {
   /// Returns the average of all elements as a Double value.
   @inlinable
   public func average<ReturnType: DivisibleArithmetic>() -> ReturnType {
      ReturnType(sum()) / ReturnType(count)
   }
}
