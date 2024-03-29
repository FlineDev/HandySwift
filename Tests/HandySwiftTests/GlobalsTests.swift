@testable import HandySwift
import XCTest

class GlobalsTests: XCTestCase {
   func testDelayed() {
      let expectation = self.expectation(description: "Wait for delay.")
      
      let callDate = Date()
      let delayTime = TimeInterval.milliseconds(1_500)
      delay(by: .milliseconds(1_500)) {
         XCTAssertEqual(callDate.timeIntervalSince1970 + delayTime, NSDate().timeIntervalSince1970, accuracy: 0.25)
         expectation.fulfill()
      }
      
      waitForExpectations(timeout: delayTime + 1.0, handler: nil)
   }
}
