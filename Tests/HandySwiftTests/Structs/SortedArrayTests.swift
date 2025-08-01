import XCTest

@testable import HandySwift

class SortedArrayTests: XCTestCase {
   func testInitialization() {
      let intArray: [Int] = [9, 1, 3, 2, 5, 4, 6, 0, 8, 7]
      let sortedIntArray = SortedArray(intArray)

      XCTAssertEqual(sortedIntArray.array, [0, 1, 2, 3, 4, 5, 6, 7, 8, 9])
   }

   func testFirstMatchingIndex() {
      let emptyArray: [Int] = []
      let sortedEmptyArray = SortedArray(emptyArray)

      XCTAssertNil(sortedEmptyArray.firstIndex { _ in true })

      let intArray: [Int] = [5, 6, 7, 8, 9, 0, 1, 2, 3, 4]
      let sortedIntArray = SortedArray(intArray)

      let expectedIndex = 3
      let resultingIndex = sortedIntArray.firstIndex { $0 >= 3 }

      XCTAssertEqual(resultingIndex, expectedIndex)
   }

   func testSubArrayToIndex() {
      let intArray: [Int] = [5, 6, 7, 8, 9, 0, 1, 2, 3, 4]
      let sortedIntArray = SortedArray(intArray)

      let index = sortedIntArray.firstIndex { $0 > 5 }!
      let sortedSubArray = sortedIntArray.prefix(upTo: index)

      XCTAssertEqual(sortedSubArray.array, [0, 1, 2, 3, 4, 5])
   }

   func testSubArrayFromIndex() {
      let intArray: [Int] = [5, 6, 7, 8, 9, 0, 1, 2, 3, 4]
      let sortedIntArray = SortedArray(intArray)

      let index = sortedIntArray.firstIndex { $0 > 5 }!
      let sortedSubArray = sortedIntArray.suffix(from: index)

      XCTAssertEqual(sortedSubArray.array, [6, 7, 8, 9])
   }

   func testCollectionFeatures() {
      let intArray: [Int] = [5, 6, 7, 8, 9, 0, 1, 2, 3, 4]
      let sortedIntArray = SortedArray(intArray)
      let expectedElementsSum = intArray.reduce(0) { result, element in result + element }

      var forEachElementsSum = 0
      sortedIntArray.forEach { forEachElementsSum += $0 }
      XCTAssertEqual(forEachElementsSum, expectedElementsSum)

      let reduceElementsSum = sortedIntArray.reduce(0) { result, element in result + element }
      XCTAssertEqual(reduceElementsSum, expectedElementsSum)

      let increasedByOneSortedArray = sortedIntArray.map { $0 + 1 }
      XCTAssertEqual(increasedByOneSortedArray, [1, 2, 3, 4, 5, 6, 7, 8, 9, 10])
   }
}
