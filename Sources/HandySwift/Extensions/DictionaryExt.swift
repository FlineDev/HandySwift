import Foundation

extension Dictionary {
   /// Initializes a new `Dictionary` and populates it with keys and values arrays. 
   /// This method is particularly useful when you have separate arrays of keys and values and you need to combine them into a single dictionary.
   /// It ensures that each key is mapped to its corresponding value based on their order in the arrays.
   ///
   /// Example:
   /// ```swift
   /// let names = ["firstName", "lastName"]
   /// let values = ["Harry", "Potter"]
   /// let person = Dictionary(keys: names, values: values)
   /// // => ["firstName": "Harry", "lastName": "Potter"]
   /// ```
   ///
   /// - Parameters:
   ///   - keys: An array containing keys to be added to the dictionary.
   ///   - values: An array containing values corresponding to the keys.
   ///
   /// - Requires: The number of elements in `keys` must be equal to the number of elements in `values`.
   ///
   /// - Returns: A new dictionary initialized with the provided keys and values arrays, or `nil` if the number of elements in the arrays differs.
   @inlinable
   public init?(keys: [Key], values: [Value]) {
      guard keys.count == values.count else { return nil }
      self.init()
      for (index, key) in keys.enumerated() { self[key] = values[index] }
   }

   /// Transforms the keys of the dictionary using the given closure, returning a new dictionary with the transformed keys.
   ///
   /// - Parameter transform: A closure that takes a key from the dictionary as its argument and returns a new key.
   /// - Returns: A dictionary with keys transformed by the `transform` closure and the same values as the original dictionary.
   /// - Throws: Rethrows any error thrown by the `transform` closure.
   ///
   /// - Warning: If the `transform` closure produces duplicate keys, the values of earlier keys will be overridden by the values of later keys in the resulting dictionary.
   ///
   /// - Example:
   /// ```
   /// let originalDict = ["one": 1, "two": 2, "three": 3]
   /// let transformedDict = originalDict.mapKeys { $0.uppercased() }
   /// // transformedDict will be ["ONE": 1, "TWO": 2, "THREE": 3]
   /// ```
   @inlinable
   public func mapKeys<K: Hashable>(_ transform: (Key) throws -> K) rethrows -> [K: Value] {
      var transformedDict: [K: Value] = [:]
      for (key, value) in self {
         transformedDict[try transform(key)] = value
      }
      return transformedDict
   }
}

// - MARK: Migration
extension Dictionary {
   @available(*, unavailable, renamed: "merge(_:uniquingKeysWith:)", message: "Append `{ $1 }` as a `uniquingKeysWith` trailing closure to migrate.")
   public mutating func merge(_ other: [Key: Value]) { fatalError() }

   @available(*, unavailable, renamed: "merging(_:uniquingKeysWith:)", message: "Remove the `with:` label and append `{ $1 }` as a `uniquingKeysWith` trailing closure to migrate.")
   public func merged(with other: [Key: Value]) -> [Key: Value] { fatalError() }
}
