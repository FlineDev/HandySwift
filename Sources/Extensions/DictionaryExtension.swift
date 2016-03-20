//
//  DictionaryExtension.swift
//  HandySwift
//
//  Created by Cihat Gündüz on 16.01.16.
//  Copyright © 2016 Flinesoft. All rights reserved.
//

import Foundation

extension Dictionary {

    /// Initializes a new `Dictionary` and fills it with keys and values arrays.
    /// 
    /// - Parameters:
    ///   - keys:       The `Array` of keys.
    ///   - values:     The `Array` of values.
    public init?(keys: [Key], values: [Value]) {
        
        guard keys.count == values.count else {
            return nil
        }
        
        self.init()
        
        for (index, key) in keys.enumerate() {
            self[key] = values[index]
        }
        
    }
    
    /// Merge given `Dictionary` into this `Dictionary` overriding existing values for matching keys.
    ///
    /// - Parameters:
    ///   - otherDictionary:    The other `Dictionary` to merge into this `Dictionary`.
    public mutating func merge(otherDictionary: [Key: Value]) {
        for (key, value) in otherDictionary {
            self[key] = value
        }
    }
    
}
