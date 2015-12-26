//
//  StringExtension.swift
//  HandySwift
//
//  Created by Cihat Gündüz on 26.12.15.
//  Copyright © 2015 Flinesoft. All rights reserved.
//

import UIKit

public extension String {
    
    public var strip: String {
        get {
            return self.stringByTrimmingCharactersInSet(.whitespaceCharacterSet())
        }
    }
    
    public var isBlank: Bool {
        get {
            return self.strip.isEmpty
        }
    }
    
}
