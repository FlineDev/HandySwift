//
//  Created by Frederick Pietschmann on 07.05.19.
//  Copyright © 2019 Flinesoft. All rights reserved.
//

import Foundation

extension Comparable {
    // MARK: - Clamp: Returning Variants
    /// Returns `self` clamped to the given limits.
    ///
    /// - Parameter limits: The closed range determining minimum & maxmimum value.
    /// - Returns:
    ///     - `self`, if it is inside the given limits.
    ///     - `lowerBound` of the given limits, if `self` is smaller than it.
    ///     - `upperBound` of the given limits, if `self` is greater than it.
    public func clamped(to limits: ClosedRange<Self>) -> Self {
        if limits.lowerBound > self {
            return limits.lowerBound
        } else if limits.upperBound < self {
            return limits.upperBound
        } else {
            return self
        }
    }

    /// Returns `self` clamped to the given limits.
    ///
    /// - Parameter limits: The partial range (from) determining the minimum value.
    /// - Returns:
    ///     - `self`, if it is inside the given limits.
    ///     - `lowerBound` of the given limits, if `self` is smaller than it.
    public func clamped(to limits: PartialRangeFrom<Self>) -> Self {
        if limits.lowerBound > self {
            return limits.lowerBound
        } else {
            return self
        }
    }

    /// Returns `self` clamped to the given limits.
    ///
    /// - Parameter limits: The partial range (through) determining the maximum value.
    /// - Returns:
    ///     - `self`, if it is inside the given limits.
    ///     - `upperBound` of the given limits, if `self` is greater than it.
    public func clamped(to limits: PartialRangeThrough<Self>) -> Self {
        if limits.upperBound < self {
            return limits.upperBound
        } else {
            return self
        }
    }

    // MARK: Mutating Variants
    /// Clamps `self` to the given limits.
    ///
    /// - `self`, if it is inside the given limits.
    /// - `lowerBound` of the given limits, if `self` is smaller than it.
    /// - `upperBound` of the given limits, if `self` is greater than it.
    ///
    /// - Parameter limits: The closed range determining minimum & maxmimum value.
    public mutating func clamp(to limits: ClosedRange<Self>) {
        self = clamped(to: limits)
    }

    /// Clamps `self` to the given limits.
    ///
    /// - `self`, if it is inside the given limits.
    /// - `lowerBound` of the given limits, if `self` is smaller than it.
    ///
    /// - Parameter limits: The partial range (from) determining the minimum value.
    public mutating func clamp(to limits: PartialRangeFrom<Self>) {
        self = clamped(to: limits)
    }

    /// Clamps `self` to the given limits.
    ///
    /// - `self`, if it is inside the given limits.
    /// - `upperBound` of the given limits, if `self` is greater than it.
    ///
    /// - Parameter limits: The partial range (through) determining the maximum value.
    public mutating func clamp(to limits: PartialRangeThrough<Self>) {
        self = clamped(to: limits)
    }
}
