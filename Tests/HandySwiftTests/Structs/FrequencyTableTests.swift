@testable import HandySwift
import XCTest

class FrequencyTableTests: XCTestCase {
   func testSample() {
      let values = ["Harry", "Hermione", "Ronald"]
      let frequencyTable = FrequencyTable(values: values) { [5, 10, 1][values.firstIndex(of: $0)!] }
      
      var allSamples: [String] = []
      
      16_000.times { allSamples.append(frequencyTable.randomElement()!) }
      
      let harryCount = allSamples.filter { $0 == "Harry" }.count
      XCTAssertGreaterThan(harryCount, 4_000)
      XCTAssertLessThan(harryCount, 6_000)
      
      let hermioneCount = allSamples.filter { $0 == "Hermione" }.count
      XCTAssertGreaterThan(hermioneCount, 9_000)
      XCTAssertLessThan(hermioneCount, 11_000)
      
      let ronaldCount = allSamples.filter { $0 == "Ronald" }.count
      XCTAssertGreaterThan(ronaldCount, 0)
      XCTAssertLessThan(ronaldCount, 2_000)
   }
   
   func testSampleWithSize() {
      let values = ["Harry", "Hermione", "Ronald"]
      let frequencyTable = FrequencyTable(values: values) { [5, 10, 1][values.firstIndex(of: $0)!] }
      
      let allSamples: [String] = frequencyTable.randomElements(count: 16_000)!
      
      let harryCount = allSamples.filter { $0 == "Harry" }.count
      XCTAssertGreaterThan(harryCount, 4_000)
      XCTAssertLessThan(harryCount, 6_000)
      
      let hermioneCount = allSamples.filter { $0 == "Hermione" }.count
      XCTAssertGreaterThan(hermioneCount, 9_000)
      XCTAssertLessThan(hermioneCount, 11_000)
      
      let ronaldCount = allSamples.filter { $0 == "Ronald" }.count
      XCTAssertGreaterThan(ronaldCount, 0)
      XCTAssertLessThan(ronaldCount, 2_000)
   }
}
