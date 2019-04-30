//
//  ColletionExtension.swift
//  HandySwift iOS
//
//  Created by Stepanov Pavel on 08/07/2018.
//  Copyright © 2018 Flinesoft. All rights reserved.
//

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

extension Collection where Element == Int {
    /// Returns the average of all elements as a Double value.
    public func average() -> Double {
        return reduce(0) { $0 + Double($1) } / Double(count)
    }
}

extension Collection where Element == Double {
    /// Returns the average of all elements as a Double value.
    public func average() -> Double {
        return reduce(0, +) / Double(count)
    }
}
