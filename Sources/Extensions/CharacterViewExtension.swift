//
//  CharacterViewExtension.swift
//  HandySwift
//
//  Created by Cihat Gündüz on 29.12.15.
//  Copyright © 2015 Flinesoft. All rights reserved.
//

import Foundation

public extension String.CharacterView {

    public var sample: Character? {
        get {
            if !self.isEmpty {
                let randomIndex = self.startIndex.advancedBy(Int(randomBelow: self.count))
                return self[randomIndex]
            }
            
            return nil
        }
    }
    
    public func sample(size size: Int) -> String.CharacterView? {
        
        if !self.isEmpty {
            var sampleElements: String.CharacterView = String.CharacterView()
            
            size.times {
                sampleElements.append(self.sample!)
            }
            
            return sampleElements
        }
        
        return String.CharacterView()
    }

    
}
