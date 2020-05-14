import Foundation
@testable import JSONFeedParser

class PostDetailsViewSpy: PostDetailsView {

    var showIndicatorCalled = false
    var hideIndicatorCalled = false
    var refreshCommentsViewCalled = false
    var displayPostsRetrievalErrorMessage = ""
    var displayedTitle = ""
    var displayedBody = ""

    func showIndicator() {
        showIndicatorCalled = true
    }

    func hideIndicator() {
        hideIndicatorCalled = true
    }

   func display(title: String) {
        displayedTitle = title
    }

    func display(body: String) {
        displayedBody = body
    }

    func refreshCommentsView() {
        refreshCommentsViewCalled = true
    }
}
