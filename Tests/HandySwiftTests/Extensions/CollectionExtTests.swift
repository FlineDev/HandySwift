import XCTest

@testable import HandySwift

class CollectionExtTests: XCTestCase {
   func testTrySubscript() {
      let testArray = [0, 1, 2, 3, 20]

      XCTAssertNil(testArray[safe: 8])
      XCTAssert(testArray[safe: -1] == nil)
      XCTAssert(testArray[safe: 0] != nil)
      XCTAssert(testArray[safe: 4] == testArray[4])

      let secondTestArray: [Int] = []
      XCTAssertNil(secondTestArray[safe: 0])
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

      #if canImport(CoreGraphics)
         let averageAsCGFloat: CGFloat = intArray.average()
         XCTAssertEqual(averageAsCGFloat, 4.333, accuracy: 0.001)
      #endif

      let doubleArray = [1.0, 2.0, 10.0]
      XCTAssertEqual(doubleArray.average(), 4.333, accuracy: 0.001)

      #if canImport(CoreGraphics)
         let cgFloatArray: [CGFloat] = [1.0, 2.0, 10.0]
         XCTAssertEqual(cgFloatArray.average(), 4.333, accuracy: 0.001)
      #endif
   }

   func testChunks() {
      XCTAssertEqual([1, 2, 3, 4, 5, 6, 7, 8, 9, 10].chunks(ofSize: 3), [[1, 2, 3], [4, 5, 6], [7, 8, 9], [10]])
      XCTAssertEqual([1, 2, 3, 4, 5, 6, 7, 8, 9, 10].chunks(ofSize: 5), [[1, 2, 3, 4, 5], [6, 7, 8, 9, 10]])
   }
}
