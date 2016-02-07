//
//  ArrayExtension.swift
//  HandySwift
//
//  Created by Cihat Gündüz on 26.12.15.
//  Copyright © 2015 Flinesoft. All rights reserved.
//

import Foundation

public extension Array {
    
    public var sample: Element? {
        get {
            if !self.isEmpty {
                let randomIndex = self.startIndex.advancedBy(Int(randomBelow: self.count))
                return self[randomIndex]
            }
            
            return nil
        }
    }
    
    public func sample(size size: Int) -> [Element]? {
        
        if !self.isEmpty {
            var sampleElements: [Element] = []
            
            size.times {
                sampleElements.append(self.sample!)
            }
            
            return sampleElements
        }
        
        return nil
    }
    
}
