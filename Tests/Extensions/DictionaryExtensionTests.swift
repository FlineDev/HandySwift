//
//  DictionaryExtensionTests.swift
//  HandySwift
//
//  Created by Cihat Gündüz on 16.01.16.
//  Copyright © 2016 Flinesoft. All rights reserved.
//

import XCTest

@testable import HandySwift

class DictionaryExtensionTests: XCTestCase {
        
    func testInitWithSameCountKeysAndValues() {
        
        let keys = Array(0..<100)
        let values = Array(0.stride(to: 10*100, by: 10))
        
        let dict = Dictionary<Int, Int>(keys: keys, values: values)
        XCTAssertNotNil(dict)
        
        if let dict = dict {
            XCTAssertEqual(dict.keys.count, keys.count)
            XCTAssertEqual(dict.values.count, values.count)
            XCTAssertEqual(dict[99]!, values.last!)
            XCTAssertEqual(dict[0]!, values.first!)
        }
        
    }
    
    func testInitWithDifferentCountKeysAndValues() {
        
        let keys = Array(0..<50)
        let values = Array(10.stride(to: 10*100, by: 10))
        
        let dict = Dictionary<Int, Int>(keys: keys, values: values)
        XCTAssertNil(dict)
        
    }
    
}
