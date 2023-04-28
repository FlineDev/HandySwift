@testable import HandySwift
import XCTest

class FloatExtTests: XCTestCase {
  func testRound() {
    var price: Float = 2.875
    price.round(fractionDigits: 2)
    XCTAssertEqual(price, 2.88)

    price = 2.875
    price.round(fractionDigits: 2, rule: .down)
    XCTAssertEqual(price, 2.87)
  }

  func testRounded() {
    let price: Float = 2.875
    XCTAssertEqual(price.rounded(fractionDigits: 2), 2.88)
    XCTAssertEqual(price.rounded(fractionDigits: 2, rule: .down), 2.87)
  }
}
