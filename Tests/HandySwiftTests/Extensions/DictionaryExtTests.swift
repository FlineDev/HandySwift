import XCTest

@testable import HandySwift

class DictionaryExtTests: XCTestCase {
   func testInitWithSameCountKeysAndValues() {
      let keys = Array(0..<100)
      let values = Array(stride(from: 0, to: 10 * 100, by: 10))

      let dict = [Int: Int](keys: keys, values: values)
      XCTAssertNotNil(dict)

      if let dict = dict {
         XCTAssertEqual(dict.keys.count, keys.count)
         XCTAssertEqual(dict.values.count, values.count)
         XCTAssertEqual(dict[99]!, values.last!)
         XCTAssertEqual(dict[0]!, values.first!)
      }
   }

   func testInitWithDifferentCountKeysAndValues() {
      let keys = Array(0..<50)
      let values = Array(stride(from: 10, to: 10 * 100, by: 10))

      let dict = [Int: Int](keys: keys, values: values)
      XCTAssertNil(dict)
   }
}
