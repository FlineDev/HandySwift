// Copyright © 2020 Flinesoft. All rights reserved.

@testable import HandySwift
import XCTest

class NSObjectExtTests: XCTestCase {
  func testWith() {
    #if !os(Linux)
      let helloString: NSString? = ("Hello, world".mutableCopy() as? NSMutableString)?.with { $0.append("!") }
      XCTAssertEqual(helloString, "Hello, world!")
    #endif
  }
}
