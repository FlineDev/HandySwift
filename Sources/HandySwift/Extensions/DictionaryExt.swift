import Foundation

extension Dictionary {
   /// Initializes a new `Dictionary` and populates it with keys and values arrays.
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
}

// MARK: Migration
extension Dictionary {
   @available(*, unavailable, renamed: "merge(_:uniquingKeysWith:)", message: "Remove the `with:` label and append `{ $1 }` as a `uniquingKeysWith` trailing closure to migrate.")
   public mutating func merge(_ other: [Key: Value]) { fatalError() }

   @available(*, unavailable, renamed: "merging(_:uniquingKeysWith:)", message: "Remove the `with:` label and append `{ $1 }` as a `uniquingKeysWith` trailing closure to migrate.")
   public func merged(with other: [Key: Value]) -> [Key: Value] { fatalError() }
}
