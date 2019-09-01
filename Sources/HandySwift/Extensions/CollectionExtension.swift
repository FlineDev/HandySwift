// Copyright © 2018 Flinesoft. All rights reserved.

import Foundation

extension Collection {
    /// Returns an element with the specified index or nil if the element does not exist.
    ///
    /// - Parameters:
    ///   - try: The index of the element.
    public subscript(try index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

extension Sequence where Element: Numeric {
    /// Returns the sum of all elements.
    public func sum() -> Element {
        return reduce(0, +)
    }
}

extension Collection where Element: DivisibleArithmetic {
    /// Returns the average of all elements.
    public func average() -> Element {
        return reduce(.zero, +) / Element(count)
    }
}

extension Collection where Element == Int {
    /// Returns the average of all elements as a Double value.
    public func average<ReturnType: DivisibleArithmetic>() -> ReturnType {
        return ReturnType(reduce(0, +)) / ReturnType(count)
    }
}
