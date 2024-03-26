@testable import HandySwift
import XCTest

class TimeIntervalExtTests: XCTestCase {
   func testUnitInitialization() {
      XCTAssertEqual(TimeInterval.days(0.5), 12 * 60 * 60, accuracy: 0.001)
      XCTAssertEqual(TimeInterval.hours(0.5), 30 * 60, accuracy: 0.001)
      XCTAssertEqual(TimeInterval.minutes(0.5), 30, accuracy: 0.001)
      XCTAssertEqual(TimeInterval.seconds(0.5), 0.5, accuracy: 0.001)
      XCTAssertEqual(TimeInterval.milliseconds(0.5), 0.5 / 1_000, accuracy: 0.001)
      XCTAssertEqual(TimeInterval.microseconds(0.5), 0.5 / 1_000_000, accuracy: 0.001)
      XCTAssertEqual(TimeInterval.nanoseconds(0.5), 0.5 / 1_000_000_000, accuracy: 0.001)
   }
   
   func testUnitConversion() {
      let timeInterval = TimeInterval.hours(4)
      let multipledTimeInterval = timeInterval * 3

      XCTAssertEqual(multipledTimeInterval.days, 0.5, accuracy: 0.001)
      XCTAssertEqual(multipledTimeInterval.hours, 12, accuracy: 0.001)
      XCTAssertEqual(multipledTimeInterval.minutes, 12 * 60, accuracy: 0.001)
      XCTAssertEqual(multipledTimeInterval.seconds, 12 * 60 * 60, accuracy: 0.001)
      XCTAssertEqual(multipledTimeInterval.milliseconds, 12 * 60 * 60 * 1_000, accuracy: 0.001)
      XCTAssertEqual(multipledTimeInterval.microseconds, 12 * 60 * 60 * 1_000_000, accuracy: 0.001)
      XCTAssertEqual(multipledTimeInterval.nanoseconds, 12 * 60 * 60 * 1_000_000_000, accuracy: 0.001)
   }

   func testDurationConversion() {
      XCTAssertEqual(TimeInterval.milliseconds(0.999).duration().timeInterval.milliseconds, 0.999, accuracy: 0.000001)
      XCTAssertEqual(TimeInterval.seconds(2.5).duration().timeInterval.seconds, 2.5, accuracy: 0.001)
      XCTAssertEqual(TimeInterval.days(5).duration().timeInterval.days, 5, accuracy: 0.001)
   }
}
