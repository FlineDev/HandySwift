//
//  TimeIntervalExtensionTests.swift
//  HandySwift
//
//  Created by Cihat Gündüz on 18.02.17.
//  Copyright © 2017 Flinesoft. All rights reserved.
//

import XCTest

@testable import HandySwift

class TimeIntervalExtensionTests: XCTestCase {
    func testUnitInitialization() {
        XCTAssertEqualWithAccuracy(Timespan.days(0.5), 12 * 60 * 60, accuracy: 0.001)
        XCTAssertEqualWithAccuracy(Timespan.hours(0.5), 30 * 60, accuracy: 0.001)
        XCTAssertEqualWithAccuracy(Timespan.minutes(0.5), 30, accuracy: 0.001)
        XCTAssertEqualWithAccuracy(Timespan.seconds(0.5), 0.5, accuracy: 0.001)
        XCTAssertEqualWithAccuracy(Timespan.milliseconds(0.5), 0.5 / 1_000, accuracy: 0.001)
        XCTAssertEqualWithAccuracy(Timespan.microseconds(0.5), 0.5 / 1_000_000, accuracy: 0.001)
        XCTAssertEqualWithAccuracy(Timespan.nanoseconds(0.5), 0.5 / 1_000_000_000, accuracy: 0.001)
    }

    func testUnitConversion() {
        let timespan = Timespan.hours(4)
        let multipledTimespan = timespan * 3

        XCTAssertEqualWithAccuracy(multipledTimespan.days, 0.5, accuracy: 0.001)
        XCTAssertEqualWithAccuracy(multipledTimespan.hours, 12, accuracy: 0.001)
        XCTAssertEqualWithAccuracy(multipledTimespan.minutes, 12 * 60, accuracy: 0.001)
        XCTAssertEqualWithAccuracy(multipledTimespan.seconds, 12 * 60 * 60, accuracy: 0.001)
        XCTAssertEqualWithAccuracy(multipledTimespan.milliseconds, 12 * 60 * 60 * 1_000, accuracy: 0.001)
        XCTAssertEqualWithAccuracy(multipledTimespan.microseconds, 12 * 60 * 60 * 1_000_000, accuracy: 0.001)
        XCTAssertEqualWithAccuracy(multipledTimespan.nanoseconds, 12 * 60 * 60 * 1_000_000_000, accuracy: 0.001)
    }
}
