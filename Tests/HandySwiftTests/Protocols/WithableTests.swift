// Copyright © 2019 Flinesoft. All rights reserved.

@testable import HandySwift
import XCTest

private struct TextFile: Withable {
    var contents: String = ""
    var linesCount: Int = 0
}

class WithableTests: XCTestCase {
    func testInitWith() {
        let textFile = TextFile { $0.contents = "Text"; $0.linesCount = 5 }
        XCTAssertEqual(textFile.contents, "Text")
        XCTAssertEqual(textFile.linesCount, 5)
    }

    func testWith() {
        let textFile = TextFile()
        XCTAssertEqual(textFile.contents, "")
        XCTAssertEqual(textFile.linesCount, 0)

        let modifiedTextFile = textFile.with { $0.contents = "Text"; $0.linesCount = 5 }
        XCTAssertEqual(textFile.contents, "")
        XCTAssertEqual(textFile.linesCount, 0)
        XCTAssertEqual(modifiedTextFile.contents, "Text")
        XCTAssertEqual(modifiedTextFile.linesCount, 5)
    }
}
