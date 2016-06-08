//
//  GlobalsTests.swift
//  HandySwift
//
//  Created by Cihat Gündüz on 07.06.16.
//  Copyright © 2016 Flinesoft. All rights reserved.
//

import XCTest

@testable import HandySwift

class GlobalsTests: XCTestCase {
    
    func testDelayed() {
        
        let expectation = expectationWithDescription("Wait for delay.")
        
        let callDate = NSDate()
        let delaySeconds = 1.5
        delay(bySeconds: delaySeconds) {
            XCTAssertEqualWithAccuracy(callDate.timeIntervalSince1970 + delaySeconds, NSDate().timeIntervalSince1970, accuracy: 0.25)
            expectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(delaySeconds + 1.0, handler: nil)

    }
    
}
