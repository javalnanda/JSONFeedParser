import Foundation
@testable import JSONFeedParser

class PostsViewRouterSpy: PostsViewRoutable {
    var passedPost: Post?

    func presentDetailsView(for post: Post) {
        passedPost = post
    }
}
