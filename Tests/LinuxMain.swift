import XCTest

import rbacTests

var tests = [XCTestCaseEntry]()
tests += rbacTests.allTests()
XCTMain(tests)