// Copyright © 2019 Flinesoft. All rights reserved.

import Foundation

@testable import HandySwift
import XCTest

class ComparableExtensionTests: XCTestCase {
    // MARK: Returning Variants
    func testClampedClosedRange() {
        let myNum = 3
        XCTAssertEqual(myNum.clamped(to: 0 ... 4), 3)
        XCTAssertEqual(myNum.clamped(to: 0 ... 2), 2)
        XCTAssertEqual(myNum.clamped(to: 4 ... 6), 4)

        let myString = "d"
        XCTAssertEqual(myString.clamped(to: "a" ... "e"), "d")
        XCTAssertEqual(myString.clamped(to: "a" ... "c"), "c")
        XCTAssertEqual(myString.clamped(to: "e" ... "g"), "e")
    }

    func testClampedPartialRangeFrom() {
        let myNum = 3
        XCTAssertEqual(myNum.clamped(to: 2...), 3)
        XCTAssertEqual(myNum.clamped(to: 4...), 4)

        let myString = "d"
        XCTAssertEqual(myString.clamped(to: "c"...), "d")
        XCTAssertEqual(myString.clamped(to: "e"...), "e")
    }

    func testClampedPartialRangeThrough() {
        let myNum = 3
        XCTAssertEqual(myNum.clamped(to: ...4), 3) // swiftlint:disable:this tuple_index
        XCTAssertEqual(myNum.clamped(to: ...2), 2) // swiftlint:disable:this tuple_index

        let myString = "d"
        XCTAssertEqual(myString.clamped(to: ..."e"), "d")
        XCTAssertEqual(myString.clamped(to: ..."c"), "c")
    }

    // MARK: Mutating Variants
    func testClampClosedRange() {
        let myNum = 3

        var myNumCopy = myNum
        myNumCopy.clamp(to: 0 ... 4)
        XCTAssertEqual(myNumCopy, 3)

        myNumCopy = myNum
        myNumCopy.clamp(to: 0 ... 2)
        XCTAssertEqual(myNumCopy, 2)

        myNumCopy = myNum
        myNumCopy.clamp(to: 4 ... 6)
        XCTAssertEqual(myNumCopy, 4)

        let myString = "d"

        var myStringCopy = myString
        myStringCopy.clamp(to: "a" ... "e")
        XCTAssertEqual(myStringCopy, "d")

        myStringCopy = myString
        myStringCopy.clamp(to: "a" ... "c")
        XCTAssertEqual(myStringCopy, "c")

        myStringCopy = myString
        myStringCopy.clamp(to: "e" ... "g")
        XCTAssertEqual(myStringCopy, "e")
    }

    func testClampPartialRangeFrom() {
        let myNum = 3

        var myNumCopy = myNum
        myNumCopy.clamp(to: 2...)
        XCTAssertEqual(myNumCopy, 3)

        myNumCopy = myNum
        myNumCopy.clamp(to: 4...)
        XCTAssertEqual(myNumCopy, 4)

        let myString = "d"

        var myStringCopy = myString
        myStringCopy.clamp(to: "c"...)
        XCTAssertEqual(myStringCopy, "d")

        myStringCopy = myString
        myStringCopy.clamp(to: "e"...)
        XCTAssertEqual(myStringCopy, "e")
    }

    func testClampPartialRangeThrough() {
        let myNum = 3

        var myNumCopy = myNum
        myNumCopy.clamp(to: ...4) // swiftlint:disable:this tuple_index
        XCTAssertEqual(myNumCopy, 3)

        myNumCopy = myNum
        myNumCopy.clamp(to: ...2) // swiftlint:disable:this tuple_index
        XCTAssertEqual(myNumCopy, 2)

        let myString = "d"

        var myStringCopy = myString
        myStringCopy.clamp(to: ..."e")
        XCTAssertEqual(myStringCopy, "d")

        myStringCopy = myString
        myStringCopy.clamp(to: ..."c")
        XCTAssertEqual(myStringCopy, "c")
    }
}
