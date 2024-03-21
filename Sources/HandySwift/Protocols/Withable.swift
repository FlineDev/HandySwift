import Foundation

/// Simple protocol to facilitate modifying objects with multiple properties in a chainable and functional manner.
public protocol Withable { /* no requirements */ }

extension Withable {
   /// Returns a copy of the object (if a struct) or uses the same object (if a class), with modifications applied.
   ///
   /// This method provides a convenient way to modify multiple properties of an object in a chainable manner.
   ///
   /// - Parameter config: A closure that accepts an inout reference to the object and modifies its properties.
   /// - Returns: A modified copy of the object (if a struct) or the same object (if a class).
   @inlinable
   public func with(_ config: (inout Self) throws -> Void) rethrows -> Self {
      var copy = self
      try config(&copy)
      return copy
   }
}

#if !os(Linux)
extension NSObject: Withable {}
#endif
