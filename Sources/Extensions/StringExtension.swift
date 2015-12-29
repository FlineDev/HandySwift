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
    
    enum AllowedCharacters {
        case Numeric
        case Alphabetic
        case AlphaNumeric
        case AllCharactersIn(String)
    }
    
    public init(randomWithLength length: Int, allowedCharactersType: AllowedCharacters) {
        
        let allowedCharsString: String = {
            switch allowedCharactersType {
            case .Numeric:
                return "0123456789"
            case .Alphabetic:
                return "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
            case .AlphaNumeric:
                return "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
            case .AllCharactersIn(let allowedCharactersString):
                return allowedCharactersString
            }
        }()
        
        self.init(allowedCharsString.characters.sample(size: length)!)
        
    }
    
}
