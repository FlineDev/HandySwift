import Foundation

/// Data structure to retrieve random values with their frequency taken into account.
///
/// Example:
/// ```swift
/// let fruits = ["apple", "banana", "orange"]
/// let frequencyTable = FrequencyTable(values: fruits) { fruit in
///     switch fruit {
///     case "apple": 5
///     case "banana": 3
///     case "orange": 2
///     default: 0
///     }
/// }
///
/// let randomFruit = frequencyTable.randomElement()
/// print(randomFruit) // Prints a random fruit considering the specified frequencies.
/// ```
public struct FrequencyTable<T> {
   @usableFromInline
   typealias Entry = (value: T, frequency: Int)

   @usableFromInline
   internal let valuesWithFrequencies: [Entry]

   /// Contains all values the amount of time of their frequencies.
   @usableFromInline
   internal let frequentValues: [T]

   /// Creates a new FrequencyTable instance with values and their frequencies provided.
   ///
   /// - Parameters:
   ///   - values: An array full of values to be saved into the frequency table.
   ///   - frequencyClosure: The closure to specify the frequency for a specific value.
   /// - Throws: Any errors thrown by the `frequencyClosure` are propagated upward.
   ///
   /// Example:
   /// ```swift
   /// let fruits = ["apple", "banana", "orange"]
   /// let frequencyTable = FrequencyTable(values: fruits) { fruit in
   ///     switch fruit {
   ///     case "apple": 5
   ///     case "banana": 3
   ///     case "orange": 2
   ///     default: 0
   ///     }
   /// }
   /// ```
   @inlinable
   public init(values: [T], frequencyClosure: (T) throws -> Int) rethrows {
      valuesWithFrequencies = try values.map { ($0, try frequencyClosure($0)) }
      frequentValues = valuesWithFrequencies.reduce(into: []) { memo, entry in
         memo += Array(repeating: entry.value, count: entry.frequency)
      }
   }

   /// Returns a random value taking frequencies into account or nil if values are empty.
   ///
   /// - Returns: A random value taking frequencies into account or nil if values are empty.
   ///
   /// Example:
   /// ```swift
   /// let fruits = ["apple", "banana", "orange"]
   /// let frequencyTable = try FrequencyTable(values: fruits) { fruit in
   ///     switch fruit {
   ///     case "apple": 5
   ///     case "banana": 3
   ///     case "orange": 2
   ///     default: 0
   ///     }
   /// }
   ///
   /// let randomFruit = frequencyTable.randomElement()
   /// print(randomFruit) // Prints a random fruit considering the specified frequencies.
   /// ```
   @inlinable
   public func randomElement() -> T? { self.frequentValues.randomElement() }

   /// Returns an array of random values taking frequencies into account or nil if values are empty.
   ///
   /// - Parameters:
   ///     - count: The size of the resulting array of random values.
   /// - Returns: An array of random values or nil if values are empty.
   ///
   /// Example:
   /// ```swift
   /// let fruits = ["apple", "banana", "orange"]
   /// let frequencyTable = try FrequencyTable(values: fruits) { fruit in
   ///     switch fruit {
   ///     case "apple": 5
   ///     case "banana": 3
   ///     case "orange": 2
   ///     default: 0
   ///     }
   /// }
   ///
   /// let randomFruits = frequencyTable.randomElements(count: 3)
   /// print(randomFruits) // Prints an array of random fruits considering the specified frequencies.
   /// ```
   @inlinable
   public func randomElements(count: Int) -> [T]? {
      guard !self.frequentValues.isEmpty else { return nil }
      return count.timesMake { self.frequentValues.randomElement()! }
   }
}

// - MARK: Migration
extension FrequencyTable {
   @available(*, unavailable, renamed: "randomElement()")
   public var sample: T? { fatalError() }

   @available(*, unavailable, renamed: "randomElements(count:)")
   public func sample(size: Int) -> [T]? { fatalError() }
}
