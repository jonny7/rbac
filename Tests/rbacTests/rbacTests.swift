import XCTest
@testable import rbac

final class rbacTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        //XCTAssertEqual(rbac().text, "Hello, World!")
    }
    
/*
     Tests that need to be written if possible as some will be confirming the tables exist
     - Confirm correct generation of tables for various DBs + that generic param
     - Add in cascades if certain things are deleted
     - confim check access, check http method works and wild card routes
 */


    static var allTests = [
        ("testExample", testExample),
    ]
}
