import Foundation

/// A type that conforms to `DivisibleArithmetic` provides basic arithmetic operations: addition, subtraction, multiplication, and division.
public protocol DivisibleArithmetic: Numeric {
   /// Initializes an instance with the given integer value.
   ///
   /// - Parameter value: An integer value to initialize the instance.
   init(_ value: Int)

   /// Divides one value by another and returns the result.
   ///
   /// - Parameters:
   ///   - lhs: The dividend.
   ///   - rhs: The divisor.
   /// - Returns: The quotient of dividing `lhs` by `rhs`.
   static func / (lhs: Self, rhs: Self) -> Self
}

extension Double: DivisibleArithmetic {}
extension Float: DivisibleArithmetic {}

#if canImport(CoreGraphics)
   import CoreGraphics

   extension CGFloat: DivisibleArithmetic {}
#endif
