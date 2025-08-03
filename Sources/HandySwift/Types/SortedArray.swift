import Foundation

/// Data structure to keep a sorted array of elements for fast access.
///
/// - Note: Use `SortedArray` over a regular array when read access (like searches) inside the array are time-sensitive. Pre-sorting elements makes mutations (such as inserts) slightly slower but searches much faster.
///
/// Example:
/// ```swift
/// // Operations such as initializing with an array literal or inserting keep the elements in the array sorted automatically:
/// var sortedNumbers: SortedArray<Int> = [7, 5]
/// sortedNumbers.insert(3)  // Complexity: O(log(n))
/// print(sortedNumbers) // Output: [3, 5, 7]
///
/// // Find the index of the first element matching a given predicate much faster (using binary search) than on regular arrays (in `O(log(n))`):
/// let index = sortedNumbers.firstIndex { $0 >= 4 }
/// print(index) // Output: Optional(1)
///
/// // Get a sub-array from the start up to (excluding) a given index without the need to sort again (in `O(1)`):
/// let prefix = sortedNumbers.prefix(upTo: 2)
/// print(prefix) // Output: [3, 5]
///
/// // Get a sub-array from a given index to the end (also in `O(1)`):
/// let suffix = sortedNumbers.suffix(from: 1)
/// print(suffix) // Output: [5, 7]
///
/// // Convert back to a regular array when needed
/// let numbers: [Int] = sortedNumbers.array
/// ```
public struct SortedArray<Element: Comparable> {
   @usableFromInline
   internal var internalArray: [Element]

   /// Returns the sorted array of elements.
   public var array: [Element] { self.internalArray }

   /// Creates a new, empty array.
   ///
   /// For example:
   ///
   ///     var emptyArray = SortedArray<Int>()
   public init() {
      self.internalArray = []
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
      self.internalArray = preSorted ? Array(sequence) : Array(sequence).sorted()
   }

   /// Returns the first index in which an element of the array satisfies the given predicate.
   /// Matching is done using binary search to minimize complexity.
   ///
   /// - Complexity: O(log(n))
   ///
   /// - Parameters:
   ///   - predicate: The predicate to match the elements against.
   /// - Returns: The index of the first matching element or `nil` if none of them matches.
   @inlinable
   public func firstIndex(where predicate: (Element) -> Bool) -> Int? {
      // cover trivial cases
      guard !self.array.isEmpty else { return nil }

      if let first = array.first, predicate(first) { return self.array.startIndex }
      if let last = array.last, !predicate(last) { return nil }

      // binary search for first matching element
      var foundMatch = false
      var lowerIndex = self.array.startIndex
      var upperIndex = self.array.endIndex

      while lowerIndex != upperIndex {
         let middleIndex = lowerIndex + (upperIndex - lowerIndex) / 2
         guard predicate(self.array[middleIndex]) else {
            lowerIndex = middleIndex + 1
            continue
         }

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

   /// Adds a new item to the sorted array.
   ///
   /// - Complexity: O(log(n))
   ///
   /// - Parameters:
   ///   - newElement: The new element to be inserted into the array.
   @inlinable
   public mutating func insert(_ newElement: Element) {
      let insertIndex = self.internalArray.firstIndex { $0 >= newElement } ?? self.internalArray.endIndex
      self.internalArray.insert(newElement, at: insertIndex)
   }

   /// Adds the contents of a sequence to the SortedArray.
   ///
   /// - Complexity: O(n * log(n))
   ///
   /// - Parameters:
   ///   - sequence
   @inlinable
   public mutating func insert<S: Sequence>(contentsOf sequence: S) where S.Iterator.Element == Element {
      sequence.forEach { self.insert($0) }
   }

   /// Removes an item from the sorted array.
   ///
   /// - Complexity: O(1)
   ///
   /// - Parameters:
   ///   - index: The index of the element to remove from the sorted array.
   @inlinable
   public mutating func remove(at index: Int) {
      self.internalArray.remove(at: index)
   }

   /// Removes an item from the sorted array.
   ///
   /// - Complexity: O(*n*), where *n* is the length of the collection.
   @inlinable
   public mutating func removeAll(where condition: (Element) -> Bool) {
      self.internalArray.removeAll(where: condition)
   }

   /// Accesses a contiguous subrange of the SortedArray's elements.
   ///
   /// - Parameter
   ///   - bounds: A range of the SortedArray's indices. The bounds of the range must be valid indices.
   @inlinable
   public subscript(bounds: Range<Int>) -> SortedArray {
      SortedArray(sequence: self.array[bounds], preSorted: true)
   }
}

extension SortedArray: BidirectionalCollection {
   /// The position of the first element in a nonempty collection.
   ///
   /// If the collection is empty, `startIndex` is equal to `endIndex`.
   public typealias Index = Array<Element>.Index

   /// The position of the first element in a nonempty collection.
   ///
   /// If the collection is empty, `startIndex` is equal to `endIndex`.
   @inlinable public var startIndex: Int {
      self.internalArray.startIndex
   }

   /// The collection's "past-the-end" position---that is, the position one greater than the last valid subscript argument.
   ///
   /// When you need a range that includes the last element of a collection, use the `..<` operator with `endIndex`.
   public var endIndex: Int {
      self.internalArray.endIndex
   }

   /// Returns the elements of the collection in sorted order.
   ///
   /// - Returns: An array containing the sorted elements of the collection.
   @inlinable
   public func sorted() -> [Element] {
      self.internalArray
   }

   /// Returns the position immediately after the given index.
   ///
   /// - Parameter index: A valid index of the collection. `index` must be less than `endIndex`.
   /// - Returns: The index value immediately after `index`.
   public func index(after index: Int) -> Int {
      self.internalArray.index(after: index)
   }

   /// Returns the position immediately before the given index.
   ///
   /// - Parameter index: A valid index of the collection. `index` must be greater than `startIndex`.
   /// - Returns: The index value immediately before `index`.
   public func index(before index: Int) -> Int {
      self.internalArray.index(before: index)
   }

   /// Accesses the element at the specified position.
   ///
   /// - Parameter position: The position of the element to access. `position` must be a valid index of the collection.
   /// - Returns: The element at the specified index.
   public subscript(position: Int) -> Element {
      self.internalArray[position]
   }
}

extension SortedArray: ExpressibleByArrayLiteral {
   /// The type of the elements of an array literal.
   public typealias ArrayLiteralElement = Element

   /// Creates an instance initialized with the given elements.
   ///
   /// - Parameter elements: A variadic list of elements of the new array.
   public init(arrayLiteral elements: Element...) {
      self.init(elements)
   }
}

extension SortedArray: Codable where Element: Codable {}

extension SortedArray: RandomAccessCollection {}

extension SortedArray: CustomStringConvertible {
   public var description: String { self.array.description }
}

// - MARK: Migration
extension SortedArray {
   @available(*, unavailable, renamed: "firstIndex(where:)")
   public func index(where predicate: (Element) -> Bool) -> Int? { fatalError() }
}
