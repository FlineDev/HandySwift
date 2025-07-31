import XCTest

@testable import HandySwift

class DispatchTimeIntervalExtTests: XCTestCase {
   func testTimeInterval() {
      let dispatchTimeInterval = DispatchTimeInterval.milliseconds(500)
      let timeInterval = dispatchTimeInterval.timeInterval

      XCTAssertEqual(timeInterval, 0.5, accuracy: 0.001)
   }
}
