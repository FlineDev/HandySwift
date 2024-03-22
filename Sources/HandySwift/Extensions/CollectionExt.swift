import Foundation

extension Collection {
   /// Returns the element at the specified index or `nil` if no element at the given index exists. 
   /// This is particularly useful when dealing with collections of elements where you're unsure if an index is within the collection's bounds.
   /// It helps prevent crashes due to accessing an index out of bounds.
   ///
   /// Example:
   /// ```swift
   /// let testArray = [0, 1, 2, 3, 20]
   /// let element = testArray[safe: 4]  // => Optional(20)
   /// let outOfBoundsElement = testArray[safe: 20] // => nil
   /// ```
   ///
   /// - Parameter index: The index of the element to retrieve.
   /// - Returns: The element at the specified index, or `nil` if the index is out of bounds.
   @inlinable
   public subscript(safe index: Index) -> Element? {
      self.indices.contains(index) ? self[index] : nil
   }
}

extension Collection where Element: DivisibleArithmetic {
   /// Returns the average of all elements. It sums up all the elements and then divides by the count of the collection. 
   /// This method requires that the element type conforms to `DivisibleArithmetic`, which includes numeric types such as `Int`, `Double`, etc.
   ///
   /// Example:
   /// ```swift
   /// let numbers: [Double] = [10.75, 20.75, 30.25, 40.25]
   /// let averageValue = numbers.average() // => 25.5
   /// ```
   ///
   /// - Returns: The average value of all elements in the collection.
   @inlinable
   public func average() -> Element {
      self.sum() / Element(self.count)
   }
}

extension Collection where Element == Int {
   /// Returns the average of all elements as a Double value. 
   /// This is useful for `Int` collections where the precision of the average calculation is important and you prefer the result to be a `Double`.
   ///
   /// Example:
   /// ```swift
   /// let numbers = [10, 20, 30, 40]
   /// let averageValue: Double = numbers.average() // => 25.0
   /// ```
   ///
   /// - Returns: The average value of all elements in the collection as a Double.
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
