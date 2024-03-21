import Foundation

/// Simple protocol to make modifying objects with multiple properties more pleasant (functional, chainable, point-free).
public protocol Withable { /* no requirements */ }

extension Withable {
   /// Create a copy (if a struct) or use same object (if class), improving chainability e.g. after init method.
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
