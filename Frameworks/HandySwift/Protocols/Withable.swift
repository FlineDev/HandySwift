//
//  Created by Cihat Gündüz on 30.04.19.
//  Copyright © 2019 Flinesoft. All rights reserved.
//

/// Simple protocol to make constructing and modifying objects with multiple properties more pleasant (functional, chainable, point-free).
public protocol Withable {
    /// Default initializer without parameters to support Withable protocol.
    init()
}

extension Withable {
    /// Construct a new instance, setting an arbitrary subset of properties.
    public init(with config: (inout Self) -> Void) {
        self.init()
        config(&self)
    }

    /// Create a copy, overriding an arbitrary subset of properties.
    public func with(_ config: (inout Self) -> Void) -> Self {
        var copy = self
        config(&copy)
        return copy
    }
}
