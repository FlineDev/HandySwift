import Foundation

extension Dictionary {
   /// Initializes a new `Dictionary` and fills it with keys and values arrays.
   ///
   /// - Parameters:
   ///   - keys:       The `Array` of keys.
   ///   - values:     The `Array` of values.
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
