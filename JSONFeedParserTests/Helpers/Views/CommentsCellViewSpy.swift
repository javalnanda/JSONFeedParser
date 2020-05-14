import Foundation
@testable import JSONFeedParser

class CommentsCellViewSpy: CommentCellView {
    var displayedName = ""
    var displayedEmail = ""
    var displayedBody = ""

    func display(name: String) {
        displayedName = name
    }

    func display(email: String) {
        displayedEmail = email
    }

    func display(body: String) {
        displayedBody = body
    }
}
