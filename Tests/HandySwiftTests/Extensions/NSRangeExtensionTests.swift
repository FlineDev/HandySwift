// Copyright © 2019 Flinesoft. All rights reserved.

@testable import HandySwift
import XCTest

class NSRangeExtensionTests: XCTestCase {
    func testInitWithSwiftRange() {
        let testStrings = ["Simple String", "👪 👨‍👩‍👦 👨‍👩‍👧 👨‍👩‍👧‍👦 👨‍👩‍👦‍👦 👨‍👩‍👧‍👧 👨‍👨‍👦 👨‍👨‍👧 👨‍👨‍👧‍👦 👨‍👨‍👦‍👦 👨‍👨‍👧‍👧 👩‍👩‍👦 👩‍👩‍👧 👩‍👩‍👧‍👦 👩‍👩‍👦‍👦 👩‍👩‍👧‍👧"]

        for string in testStrings {
            XCTAssertEqual((string as NSString).substring(with: NSRange(string.fullRange, in: string)), string)
        }
    }
}
