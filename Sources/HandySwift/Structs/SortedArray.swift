// Copyright © 2015 Flinesoft. All rights reserved.

import Foundation

/// Data structure to keep a sorted array of elements for fast access.
public struct SortedArray<Element: Comparable> {
    // MARK: - Stored Instance Properties
    @usableFromInline internal var internalArray: [Element]

    /// Returns the sorted array of elements.
    public var array: [Element] { self.internalArray }

    // MARK: - Initializers
    /// Creates a new, empty array.
    ///
    /// For example:
    ///
    ///     var emptyArray = SortedArray<Int>()
    public init() {
        internalArray = []
    }

    /// Creates a new SortedArray with a given sequence of elements and sorts its elements.
    ///
    /// - Complexity: The same as `sort()` on an Array –- probably O(n * log(n)).
    ///
    /// - Parameters:
    ///     - array: The array to be initially sorted and saved.
    public init<S: Sequence>(_ sequence: S) where S.Iterator.Element == Element {
        self.init(sequence: sequence, preSorted: false)
    }

    @usableFromInline
    internal init<S: Sequence>(sequence: S, preSorted: Bool) where S.Iterator.Element == Element {
        internalArray = preSorted ? Array(sequence) : Array(sequence).sorted()
    }

    // MARK: - Instance Methods
    /// Returns the first index in which an element of the array satisfies the given predicate.
    /// Matching is done using binary search to minimize complexity.
    ///
    /// - Complexity: O(log(n))
    ///
    /// - Parameters:
    ///   - predicate: The predicate to match the elements against.
    /// - Returns: The index of the first matching element or `nil` if none of them matches.
    @inlinable
    public func index(where predicate: (Element) -> Bool) -> Int? {
        // cover trivial cases
        guard !array.isEmpty else { return nil }
        // swiftlint:disable all
        if let first = array.first, predicate(first) { return array.startIndex } // AnyLint.skipHere: IfAsGuard
        if let last = array.last, !predicate(last) { return nil } // AnyLint.skipHere: IfAsGuard
        // swiftlint:enable all

        // binary search for first matching element
        var foundMatch = false
        var lowerIndex = array.startIndex
        var upperIndex = array.endIndex

        while lowerIndex != upperIndex {
            let middleIndex = lowerIndex + (upperIndex - lowerIndex) / 2
            guard predicate(array[middleIndex]) else { lowerIndex = middleIndex + 1; continue }

            upperIndex = middleIndex
            foundMatch = true
        }

        guard foundMatch else { return nil }
        return lowerIndex
    }

    /// Returns a sub array of a SortedArray up to a given index (excluding it) without resorting.
    ///
    /// - Complexity: O(1)
    ///
    /// - Parameters:
    ///   - index: The upper bound index until which to include elements.
    /// - Returns: A new SortedArray instance including all elements until the specified index (exluding it).
    @inlinable
    public func prefix(upTo index: Int) -> SortedArray {
        let subarray = Array(array[array.indices.prefix(upTo: index)])
        return SortedArray(sequence: subarray, preSorted: true)
    }

    /// Returns a sub array of a SortedArray up to a given index (including it) without resorting.
    ///
    /// - Complexity: O(1)
    ///
    /// - Parameters:
    ///   - index: The upper bound index until which to include elements.
    /// - Returns: A new SortedArray instance including all elements until the specified index (including it).
    @inlinable
    public func prefix(through index: Int) -> SortedArray {
        let subarray = Array(array[array.indices.prefix(through: index)])
        return SortedArray(sequence: subarray, preSorted: true)
    }

    /// Returns a sub array of a SortedArray starting at a given index without resorting.
    ///
    /// - Complexity: O(1)
    ///
    /// - Parameters:
    ///   - index: The lower bound index from which to start including elements.
    /// - Returns: A new SortedArray instance including all elements starting at the specified index.
    @inlinable
    public func suffix(from index: Int) -> SortedArray {
        let subarray = Array(array[array.indices.suffix(from: index)])
        return SortedArray(sequence: subarray, preSorted: true)
    }

    // MARK: - Mutating Methods
    /// Adds a new item to the sorted array.
    ///
    /// - Complexity: O(log(n))
    ///
    /// - Parameters:
    ///   - newElement: The new element to be inserted into the array.
    @inlinable
    public mutating func insert(_ newElement: Element) {
        let insertIndex = internalArray.firstIndex { $0 >= newElement } ?? internalArray.endIndex
        internalArray.insert(newElement, at: insertIndex)
    }

    /// Adds the contents of a sequence to the SortedArray.
    ///
    /// - Complexity: O(n * log(n))
    ///
    /// - Parameters:
    ///   - sequence
    @inlinable
    public mutating func insert<S: Sequence>(contentsOf sequence: S) where S.Iterator.Element == Element {
        sequence.forEach { insert($0) }
    }

    /// Removes an item from the sorted array.
    ///
    /// - Complexity: O(1)
    ///
    /// - Parameters:
    ///   - index: The index of the element to remove from the sorted array.
    @inlinable
    public mutating func remove(at index: Int) {
        internalArray.remove(at: index)
    }

    /// Removes an item from the sorted array.
    ///
    /// - Complexity: O(*n*), where *n* is the length of the collection.
    @inlinable
    public mutating func removeAll(where condition: (Element) -> Bool) {
        internalArray.removeAll(where: condition)
    }

    /// Accesses a contiguous subrange of the SortedArray's elements.
    ///
    /// - Parameter
    ///   - bounds: A range of the SortedArray's indices. The bounds of the range must be valid indices.
    @inlinable
    public subscript(bounds: Range<Int>) -> SortedArray {
        SortedArray(sequence: array[bounds], preSorted: true)
    }
}

extension SortedArray: BidirectionalCollection {
    public typealias Index = Array<Element>.Index

    @inlinable public var startIndex: Int {
        internalArray.startIndex
    }

    @inlinable public var endIndex: Int {
        internalArray.endIndex
    }

    @inlinable
    public func sorted() -> [Element] {
        internalArray
    }

    @inlinable
    public func index(after index: Int) -> Int {
        internalArray.index(after: index)
    }

    public func index(before index: Int) -> Int {
        internalArray.index(before: index)
    }

    @inlinable
    public subscript(position: Int) -> Element {
        internalArray[position]
    }
}

extension SortedArray: ExpressibleByArrayLiteral {
    public typealias ArrayLiteralElement = Element

    public init(arrayLiteral elements: Element...) {
        self.init(elements)
    }
}

extension SortedArray: Codable where Element: Codable {}

extension SortedArray: RandomAccessCollection {}
