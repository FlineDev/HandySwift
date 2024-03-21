import Foundation

extension RandomAccessCollection where Index == Int {
   /// Returns a given number of random elements from the `Array`.
   ///
   /// - Parameters:
   ///   - count: The number of random elements wanted.
   /// - Returns: An array with the given number of random elements or `nil` if empty.
   @inlinable
   public func randomElements(count: Int) -> [Element]? {
      guard !self.isEmpty else { return nil }
      return count.timesMake { self.randomElement()! }
   }
}

// MARK: Migration
extension RandomAccessCollection where Index == Int {
   @available(*, unavailable, renamed: "randomElement()")
   public var sample: Element? { fatalError() }

   @available(*, unavailable, renamed: "randomElements(count:)")
   public func sample(size: Int) -> [Element]? { fatalError() }
}
