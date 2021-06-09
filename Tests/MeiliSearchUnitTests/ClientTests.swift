@testable import MeiliSearch
import XCTest

class ClientTests: XCTestCase {

  private let session = MockURLSession()

  func testValidHostURL() {
    session.pushEmpty(code: 200)
    XCTAssertNotNil(try? MeiliSearch(Config.default(apiKey: "masterKey", session: session)))
  }

  func testWrongHostURL() {
    XCTAssertNotNil(try MeiliSearch(Config(hostURL: "http://localhost:1234")))
  }

  func testNotValidHostURL() {
    XCTAssertThrowsError(try MeiliSearch(Config(hostURL: "Not valid host"))) { error in
      XCTAssertEqual(error as! MeiliSearch.Error, MeiliSearch.Error.hostNotValid)
    }
  }

  static var allTests = [
      ("testValidHostURL", testValidHostURL),
      ("testWrongHostURL", testWrongHostURL)
      ("testNotValidHostURL", testNotValidHostURL)
  ]

}
