//
//  ArrayExtension.swift
//  HandySwift
//
//  Created by Cihat Gündüz on 26.12.15.
//  Copyright © 2015 Flinesoft. All rights reserved.
//

import UIKit

public extension Array {
    
    public var sample: Element? {
        get {
            if self.count > 0 {
                let randomIndex = Array<Element>.Index(arc4random_uniform(UInt32(self.count)))
                return self[randomIndex]
            }
            
            return nil
        }
    }
    
    public func sample(size size: Int) -> [Element]? {
        
        if self.count > 0 {
            var sampleElements: [Element] = []
            
            if self.count > 0 {
                
                while sampleElements.count < size {
                    sampleElements.append(self.sample!)
                }
                
            }
            
            return sampleElements
        }
        
        return nil
    }
    
}
