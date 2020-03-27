// Copyright © 2019 Flinesoft. All rights reserved.

/// A type which conforms to DivisibleArithmetic provides the basic arithmetic operations: additon, subtraction, multiplication and division.
public protocol DivisibleArithmetic: Numeric {
    init(_ value: Int)
    static func / (lhs: Self, rhs: Self) -> Self
}

extension Double: DivisibleArithmetic {}
extension Float: DivisibleArithmetic {}

#if canImport(CoreGraphics)
    import CoreGraphics

    extension CGFloat: DivisibleArithmetic {}
#endif
