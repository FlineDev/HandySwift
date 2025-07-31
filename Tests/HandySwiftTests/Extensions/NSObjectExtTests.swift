import XCTest

@testable import HandySwift

class NSObjectExtTests: XCTestCase {
   func testWith() {
      #if !os(Linux)
         let helloString: NSString? = ("Hello, world".mutableCopy() as? NSMutableString)?.with { $0.append("!") }
         XCTAssertEqual(helloString, "Hello, world!")
      #endif
   }
}
