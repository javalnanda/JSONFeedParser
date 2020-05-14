import XCTest

class UITestCase: XCTestCase {
    public var app: UITestApplication!

    override open func setUp() {
        super.setUp()
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        app = UITestApplication()
        app.setUp()
    }

    override open func tearDown() {
        app.tearDown()
        super.tearDown()
    }
}

extension UITestCase {
    public func start(with launchArgs: [String] = ["UITestMode"]) -> UITestApplication {
        app.start(with: launchArgs)
        return app
    }
}

extension UITestCase {
    func tapNavigationBackButton() {
        app.navigationBars.buttons.element(boundBy: 0).tap()
    }
}
