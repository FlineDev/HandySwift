import XCTest

@testable import HandySwift

class IntExtTests: XCTestCase {
   func testTimesMethod() {
      var testString = ""

      0.times { testString += "." }
      XCTAssertEqual(testString, "")

      3.times { testString += "." }
      XCTAssertEqual(testString, "...")
   }

   func testTimesMakeMethod() {
      var testArray = 0.timesMake { 1 }
      XCTAssertEqual(testArray, [])

      testArray = 3.timesMake { 1 }
      XCTAssertEqual(testArray, [1, 1, 1])

      var index = 0
      testArray = 3.timesMake {
         index += 1
         return index
      }
      XCTAssertEqual(testArray, [1, 2, 3])
   }
}
