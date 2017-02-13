//
//  DispatchTimeIntervalExtensionTests.swift
//  HandySwift
//
//  Created by Cihat Gündüz on 13.02.17.
//  Copyright © 2017 Flinesoft. All rights reserved.
//

import XCTest

@testable import HandySwift

class DispatchTimeIntervalTests: XCTestCase {
    func testTimeInterval() {
        let dispatchTimeInterval = DispatchTimeInterval.milliseconds(500)
        let timeInterval = dispatchTimeInterval.timeInterval

        XCTAssertEqualWithAccuracy(timeInterval, 0.5, accuracy: 0.001)
    }
}
