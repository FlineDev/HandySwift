//
//  CollectionExtensionTests.swift
//  HandySwift iOS
//
//  Created by Stepanov Pavel on 08/07/2018.
//  Copyright © 2018 Flinesoft. All rights reserved.
//

@testable import HandySwift
import XCTest

class CollectionExtensionTests: XCTestCase {
    func testSafeSubscript() {
        let testArray = [0, 1, 2, 3, 20]
        
        XCTAssertNil(testArray[safe: 8])
        XCTAssert(testArray[safe: -1] == nil)
        
        XCTAssert(testArray[safe: 0] != nil)
        XCTAssert(testArray[safe: 4] == testArray[4])
    }
}
