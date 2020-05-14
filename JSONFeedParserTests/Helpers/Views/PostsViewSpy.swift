import Foundation
@testable import JSONFeedParser

class PostsViewSpy: PostsView {
    var showIndicatorCalled = false
    var hideIndicatorCalled = false
    var refreshPostsViewCalled = false
    var displayPostsRetrievalErrorMessage = ""

    func showIndicator() {
        showIndicatorCalled = true
    }

    func hideIndicator() {
        hideIndicatorCalled = true
    }

    func refreshPostsView() {
        refreshPostsViewCalled = true
    }

    func displayPostsRetrievalError(message: String) {
        displayPostsRetrievalErrorMessage = message
    }


}
