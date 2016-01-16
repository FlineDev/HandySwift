//
//  DictionaryExtension.swift
//  HandySwift
//
//  Created by Cihat Gündüz on 16.01.16.
//  Copyright © 2016 Flinesoft. All rights reserved.
//

import Foundation

extension Dictionary {

    public init?(keys: [Key], values: [Value]) {
        
        guard keys.count == values.count else {
            return nil
        }
        
        self.init()
        
        for (index, key) in keys.enumerate() {
            self[key] = values[index]
        }
        
    }
    
}
