import Foundation
import XCTest

final class PostsPage: UITestBase {
    var navigationTitle: XCUIElement {
        return app.navigationBars[Accessibility.Posts.navigationTitle]
    }

    var tableCells: XCUIElementQuery {
        return app.tables.cells
    }

    var firstCell: XCUIElement {
        return tableCells.firstMatch
    }

    var postTitleLable: XCUIElement {
        return firstCell.staticTexts[Accessibility.Detail.postTitleLabel]
    }

    var postBodyLable: XCUIElement {
        return firstCell.staticTexts[Accessibility.Detail.postBodyLabel]
    }
}

extension PostsPage {
    func navigationTitleIsVisible(timeout: TimeInterval = 5.0) {
        navigationTitle.checkExistence(timeout: timeout, error: "There should be a header label")
    }

    func validateCellsAreRendered() {
        XCTAssertTrue(tableCells.count > 0)
        XCTAssertFalse(postTitleLable.label.isEmpty)
        XCTAssertFalse(postBodyLable.label.isEmpty)
    }
    
    func tapOnCell() {
        firstCell.tap()
    }
}

// MARK: - Add to Application

extension UITestApplication {
    var postsPage: PostsPage {
        return PostsPage(app: self)
    }
}
