// Copyright © 2015 Flinesoft. All rights reserved.

import Foundation

extension Int {
    /// Initializes a new `Int ` instance with a random value below a given `Int`.
    ///
    /// - Parameters:
    ///   - randomBelow: The upper bound value to create a random value with.
    public init?(randomBelow upperLimit: Int) {
        guard upperLimit > 0 else { return nil }
        self = .random(in: 0 ..< upperLimit)
    }

    /// Initializes a new `Int ` instance with a random value below a given `Int`.
    ///
    /// - Parameters:
    ///   - randomBelow: The upper bound value to create a random value with.
    ///   - generator: The `RandomNumberGenerator` source that should be used to generate random numbers.
    public init?<Generator: RandomNumberGenerator>(randomBelow upperLimit: Int, using generator: inout Generator) {
        guard upperLimit > 0 else { return nil }
        self = .random(in: 0 ..< upperLimit, using: &generator)
    }

    /// Runs the code passed as a closure the specified number of times.
    ///
    /// - Parameters:
    ///   - closure: The code to be run multiple times.
    @inlinable
    public func times(_ closure: () throws -> Void) rethrows {
        guard self > 0 else { return }
        for _ in 0 ..< self { try closure() }
    }

    /// Runs the code passed as a closure the specified number of times
    /// and creates an array from the return values.
    ///
    /// - Parameters:
    ///   - closure: The code to deliver a return value multiple times.
    @inlinable
    public func timesMake<ReturnType>(_ closure: () throws -> ReturnType) rethrows -> [ReturnType] {
        guard self > 0 else { return [] }
        return try (0 ..< self).map { _ in try closure() }
    }
}
