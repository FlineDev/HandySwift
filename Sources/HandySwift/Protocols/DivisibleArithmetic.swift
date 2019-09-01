// Copyright © 2019 Flinesoft. All rights reserved.

import CoreGraphics

/// A type which conforms to DivisibleArithmetic provides the basic arithmetic operations: additon, subtraction, multiplication and division.
public protocol DivisibleArithmetic: Numeric {
    init(_ value: Int)
    static func /(lhs: Self, rhs: Self) -> Self
}

extension Double: DivisibleArithmetic {}
extension Float: DivisibleArithmetic {}
extension CGFloat: DivisibleArithmetic {}
