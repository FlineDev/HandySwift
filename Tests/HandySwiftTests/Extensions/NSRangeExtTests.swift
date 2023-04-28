@testable import HandySwift
import XCTest

class NSRangeExtTests: XCTestCase {
  func testInitWithSwiftRange() {
    let testStrings = ["Simple String", "👪 👨‍👩‍👦 👨‍👩‍👧 👨‍👩‍👧‍👦 👨‍👩‍👦‍👦 👨‍👩‍👧‍👧 👨‍👨‍👦 👨‍👨‍👧 👨‍👨‍👧‍👦 👨‍👨‍👦‍👦 👨‍👨‍👧‍👧 👩‍👩‍👦 👩‍👩‍👧 👩‍👩‍👧‍👦 👩‍👩‍👦‍👦 👩‍👩‍👧‍👧"]

    for string in testStrings {
      XCTAssertEqual((string as NSString).substring(with: NSRange(string.fullRange, in: string)), string)
    }
  }
}
