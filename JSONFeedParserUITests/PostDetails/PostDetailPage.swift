import Foundation
import XCTest

final class PostDetailsPage: UITestBase {
    var navigationTitle: XCUIElement {
        return app.navigationBars[Accessibility.Detail.navigationTitle]
    }

    var postTitleLable: XCUIElement {
        return app.staticTexts[Accessibility.Detail.postTitleLabel]
    }

    var postBodyLable: XCUIElement {
        return app.staticTexts[Accessibility.Detail.postBodyLabel]
    }

    var commentsHeaderLabel: XCUIElement {
        return app.staticTexts[Accessibility.Detail.commentsLabel]
    }

    var commentAuthorLabel: XCUIElement {
        return firstCell.staticTexts[Accessibility.CommentCell.commentAuthorLabel]
    }

    var commentEmailLabel: XCUIElement {
        return firstCell.staticTexts[Accessibility.CommentCell.commentEmailLabel]
    }

    var commentBodyLabel: XCUIElement {
        return firstCell.staticTexts[Accessibility.CommentCell.commentBodyLabel]
    }

    var tableCells: XCUIElementQuery {
        return app.tables.cells
    }

    var firstCell: XCUIElement {
        return tableCells.firstMatch
    }
}

extension PostDetailsPage {
    func navigationTitleIsVisible(timeout: TimeInterval = 5.0) {
        navigationTitle.checkExistence(timeout: timeout, error: "There should be a header label")
    }

    func validatePostIsRendered() {
        XCTAssertFalse(postTitleLable.label.isEmpty)
        XCTAssertFalse(postBodyLable.label.isEmpty)
        XCTAssertFalse(commentsHeaderLabel.label.isEmpty)
    }

    func validateCellsAreRendered() {
        XCTAssertTrue(tableCells.count > 0)
        XCTAssertFalse(commentAuthorLabel.label.isEmpty)
        XCTAssertFalse(commentEmailLabel.label.isEmpty)
        XCTAssertFalse(commentBodyLabel.label.isEmpty)
    }

    func tapOnCell() {
        firstCell.tap()
    }
}

// MARK: - Add to Application

extension UITestApplication {
    var postDetailsPage: PostDetailsPage {
        return PostDetailsPage(app: self)
    }
}
