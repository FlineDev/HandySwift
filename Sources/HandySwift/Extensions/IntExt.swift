extension Int {
   /// Runs the code passed as a closure the specified number of times.
   /// This method is useful for repeating an action multiple times, such as logging a message or incrementing a value.
   /// It guards against negative values, ensuring the closure is only run for positive counts.
   ///
   /// Example:
   /// ```swift
   /// 3.times { print("Hello World!") }
   /// // This will print "Hello World!" 3 times.
   /// ```
   ///
   /// - Parameters:
   ///   - closure: The code to be run multiple times.
   /// - Throws: Any error thrown by the closure.
   @inlinable
   public func times(_ closure: () throws -> Void) rethrows {
      guard self > 0 else { return }
      for _ in 0..<self { try closure() }
   }

   /// Runs the code passed as a closure the specified number of times and creates an array from the return values.
   /// This method can be particularly useful for generating arrays with dynamic content, where each element is the result of a closure execution.
   ///
   /// Example:
   /// ```swift
   /// let intArray = 5.timesMake { Int.random(in: 1...100) }
   /// // This may generate an array like [42, 77, 11, 38, 23]
   /// ```
   ///
   /// - Parameters:
   ///   - closure: The code to deliver a return value multiple times.
   /// - Returns: An array containing the return values of each iteration.
   /// - Throws: Any error thrown by the closure.
   @inlinable
   public func timesMake<ReturnType>(_ closure: () throws -> ReturnType) rethrows -> [ReturnType] {
      guard self > 0 else { return [] }
      return try (0..<self).map { _ in try closure() }
   }
}

// - MARK: Migration
extension Int {
   @available(*, unavailable, renamed: "Int.random(in:)", message: "Pass `0..<upperLimit` for the `in` parameter to get same behavior.")
   public init?(randomBelow upperLimit: Int) { fatalError() }

   @available(*, unavailable, renamed: "Int.random(in:using:)", message: "Pass `0..<upperLimit` for the `in` parameter to get same behavior.")
   public init?<Generator: RandomNumberGenerator>(randomBelow upperLimit: Int, using generator: inout Generator) { fatalError() }
}
