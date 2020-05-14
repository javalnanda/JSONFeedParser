import XCTest

extension XCUIElement {
    func checkExistence(timeout: TimeInterval, error: String) {
        XCTAssertTrue(self.waitForExistence(timeout: timeout), error)
    }
}
