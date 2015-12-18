//
//  IntegerTypeExtensionTests.swift
//  HandySwift
//
//  Created by Cihat Gündüz on 18.12.15.
//  Copyright © 2015 Flinesoft. All rights reserved.
//

import XCTest

@testable import HandySwift

class IntegerTypeExtensionTests: XCTestCase {
        
    func testTimesClosureWithoutArgument() {
        var testString = ""
        
        0.times {
            testString += "."
        }
        
        XCTAssertEqual(testString, "")
        
        3.times {
            testString += "."
        }
        
        XCTAssertEqual(testString, "...")
    }
    
    func testTimesClosureWithArgument() {
        var testString = ""
        
        0.times { i in
            testString += "\(i)"
        }
        
        XCTAssertEqual(testString, "")
        
        3.times { i in
            testString += "\(i)"
        }
        
        XCTAssertEqual(testString, "123")
    }
    
    
}
