import Foundation
import XCTest

@testable import HandySwift

final class GregorianDayTests: XCTestCase {
   func testAdvancedByMonths() {
      let day = GregorianDay(year: 2024, month: 03, day: 26)
      let advancedByAMonth = day.advanced(byMonths: 1)

      XCTAssertEqual(advancedByAMonth.year, 2024)
      XCTAssertEqual(advancedByAMonth.month, 04)
      XCTAssertEqual(advancedByAMonth.day, 26)
   }

   func testReversedByYears() {
      let day = GregorianDay(year: 2024, month: 03, day: 26)
      let reversedByTwoYears = day.reversed(byYears: 2)

      XCTAssertEqual(reversedByTwoYears.year, 2022)
      XCTAssertEqual(reversedByTwoYears.month, 03)
      XCTAssertEqual(reversedByTwoYears.day, 26)
   }
}
