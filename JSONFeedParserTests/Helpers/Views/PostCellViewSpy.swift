import Foundation
@testable import JSONFeedParser

class PostCellViewSpy: PostCellView {
    var displayedTitle = ""
    var displayedBody = ""

    func display(title: String) {
        displayedTitle = title
    }

    func display(body: String) {
        displayedBody = body
    }
}
