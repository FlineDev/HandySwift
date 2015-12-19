//
//  IntegerTypeExtension.swift
//  HandySwift
//
//  Created by Cihat Gündüz on 18.12.15.
//  Copyright © 2015 Flinesoft. All rights reserved.
//

import Foundation

public extension IntegerType {

    public func times(closure: () -> ()) {
        guard self > 0 else { return }
        
        for _ in 1...self {
            closure()
        }
    }
    
}
