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
        let expectation = self.expectation(description: "Wait for delay.")

        let callDate = Date()
        let delayTime = Timespan.milliseconds(1_500)
        delay(by: .milliseconds(1_500)) {
            XCTAssertEqualWithAccuracy(callDate.timeIntervalSince1970 + delayTime, NSDate().timeIntervalSince1970, accuracy: 0.25)
            expectation.fulfill()
        }

        waitForExpectations(timeout: delayTime + 1.0, handler: nil)
    }

    func testEvery() {
        let expectation = self.expectation(description: "Wait for three executions.")
        var counter = 0
        let timer = every(.milliseconds(10)) {
            counter += 1
            if counter >= 3 {
                expectation.fulfill()
            }
        }
        waitForExpectations(timeout: 2) { error in
            timer.cancel()
        }
    }
}
