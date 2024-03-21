@testable import HandySwift
import XCTest

class ArrayExtTests: XCTestCase {
   struct T: Equatable {
      let a: Int, b: Int
      
      static func == (lhs: T, rhs: T) -> Bool {
         lhs.a == rhs.a && lhs.b == rhs.b
      }
   }
   
   let unsortedArray: [T] = [T(a: 0, b: 2), T(a: 1, b: 2), T(a: 2, b: 2), T(a: 3, b: 1), T(a: 4, b: 1), T(a: 5, b: 0)]
   let sortedArray: [T] = [T(a: 5, b: 0), T(a: 3, b: 1), T(a: 4, b: 1), T(a: 0, b: 2), T(a: 1, b: 2), T(a: 2, b: 2)]
   
   func testRandomElements() {
      XCTAssertNil(([] as [Int]).randomElements(count: 2))
      XCTAssertEqual([1, 2, 3].randomElements(count: 2)!.count, 2)
      XCTAssertEqual([1, 2, 3].randomElements(count: 10)!.count, 10)
   }
}
