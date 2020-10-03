// Copyright © 2020 Flinesoft. All rights reserved.

/// Simple protocol to make modifying objects with multiple properties more pleasant (functional, chainable, point-free).
public protocol Withable { /* no requirements */ }

extension Withable {
    @available(*, unavailable, message: "Add `().with` after the type name, e.g. `Foo().with { $0.bar = 5 }` instead of `Foo { $0.bar = 5 }`.")
    @inlinable
    public init(with config: (inout Self) -> Void) { // swiftlint:disable:this missing_docs
        fatalError("Function no longer available. Xcode should actually show an unavailable error with message and not compile.")
    }

    /// Create a copy (if a struct) or use same object (if class), improving chainability e.g. after init method.
    @inlinable
    public func with(_ config: (inout Self) throws -> Void) rethrows -> Self {
        var copy = self
        try config(&copy)
        return copy
    }
}
