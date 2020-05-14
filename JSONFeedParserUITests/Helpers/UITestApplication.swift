import XCTest

public final class UITestApplication: XCUIApplication {

    func setUp() {}

    func tearDown() {}

    func start(with launchArgs: [String] = ["UITestMode"]) {
        for launchArg in launchArgs {
            launchArguments.append(launchArg)
        }
        launch()
    }
}
