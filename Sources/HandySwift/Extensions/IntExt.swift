import Foundation

extension Int {
   /// Runs the code passed as a closure the specified number of times.
   ///
   /// - Parameters:
   ///   - closure: The code to be run multiple times.
   @inlinable
   public func times(_ closure: () throws -> Void) rethrows {
      guard self > 0 else { return }
      for _ in 0..<self { try closure() }
   }
   
   /// Runs the code passed as a closure the specified number of times
   /// and creates an array from the return values.
   ///
   /// - Parameters:
   ///   - closure: The code to deliver a return value multiple times.
   @inlinable
   public func timesMake<ReturnType>(_ closure: () throws -> ReturnType) rethrows -> [ReturnType] {
      guard self > 0 else { return [] }
      return try (0..<self).map { _ in try closure() }
   }
}

// MARK: Migration
extension Int {
   @available(*, unavailable, renamed: "Int.random(in:)", message: "Pass `0..<upperLimit` for the `in` parameter to get same behavior.")
   public init?(randomBelow upperLimit: Int) { fatalError() }

   @available(*, unavailable, renamed: "Int.random(in:using:)", message: "Pass `0..<upperLimit` for the `in` parameter to get same behavior.")
   public init?<Generator: RandomNumberGenerator>(randomBelow upperLimit: Int, using generator: inout Generator) { fatalError() }
}
