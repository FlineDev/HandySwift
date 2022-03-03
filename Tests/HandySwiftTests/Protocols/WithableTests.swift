// Copyright © 2020 Flinesoft. All rights reserved.

@testable import HandySwift
import XCTest

private struct TextFile: Withable {
  var contents: String
  var linesCount: Int
}

class WithableTests: XCTestCase {
  func testWith() {
    let textFile = TextFile(contents: "", linesCount: 0)
    XCTAssertEqual(textFile.contents, "")
    XCTAssertEqual(textFile.linesCount, 0)

    let modifiedTextFile = textFile.with { $0.contents = "Text"; $0.linesCount = 5 }
    XCTAssertEqual(textFile.contents, "")
    XCTAssertEqual(textFile.linesCount, 0)
    XCTAssertEqual(modifiedTextFile.contents, "Text")
    XCTAssertEqual(modifiedTextFile.linesCount, 5)
  }
}
