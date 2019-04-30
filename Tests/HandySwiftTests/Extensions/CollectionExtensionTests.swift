//
//  Created by Stepanov Pavel on 08/07/2018.
//  Copyright © 2018 Flinesoft. All rights reserved.
//

@testable import HandySwift
import XCTest

class CollectionExtensionTests: XCTestCase {
    func testTrySubscript() {
        let testArray = [0, 1, 2, 3, 20]

        XCTAssertNil(testArray[try: 8])
        XCTAssert(testArray[try: -1] == nil)
        XCTAssert(testArray[try: 0] != nil)
        XCTAssert(testArray[try: 4] == testArray[4])

        let secondTestArray = [Int]()
        XCTAssertNil(secondTestArray[try: 0])
    }

    func testSum() {
        let intArray = [1, 2, 3, 4, 5]
        XCTAssertEqual(intArray.sum(), 15)

        let doubleArray = [1.0, 2.0, 3.0, 4.0, 5.0]
        XCTAssertEqual(doubleArray.sum(), 15.0, accuracy: 0.001)
    }

    func testAverage() {
        let intArray = [1, 2, 10]
        XCTAssertEqual(intArray.average(), 4.333, accuracy: 0.001)

        let doubleArray = [1.0, 2.0, 10.0]
        XCTAssertEqual(doubleArray.average(), 4.333, accuracy: 0.001)
    }
}
