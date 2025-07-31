import Foundation

extension RandomAccessCollection where Index == Int {
   /// Returns a given number of random elements from the collection.
   /// This method is useful when you need a subset of elements for sampling, testing, or any other case where random selection from a collection is required.
   /// If the collection is empty, `nil` is returned instead.
   ///
   /// Example:
   /// ```swift
   /// let numbers = [1, 2, 3, 4, 5]
   /// if let randomNumbers = numbers.randomElements(count: 3) {
   ///     print(randomNumbers)
   /// }
   /// // Output: [2, 1, 4] (example output, actual output will vary)
   /// ```
   ///
   /// - Parameters:
   ///   - count: The number of random elements wanted.
   /// - Returns: An array with the given number of random elements or `nil` if the collection is empty.
   @inlinable
   public func randomElements(count: Int) -> [Element]? {
      guard !self.isEmpty else { return nil }
      return count.timesMake { self.randomElement()! }
   }
}

// - MARK: Migration
extension RandomAccessCollection where Index == Int {
   @available(*, unavailable, renamed: "randomElement()")
   public var sample: Element? { fatalError() }

   @available(*, unavailable, renamed: "randomElements(count:)")
   public func sample(size: Int) -> [Element]? { fatalError() }
}
