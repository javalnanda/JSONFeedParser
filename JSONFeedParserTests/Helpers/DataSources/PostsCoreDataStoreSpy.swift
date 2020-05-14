import Foundation
@testable import JSONFeedParser

class PostsCoreDataStoreSpy: PostsCoreDataStoreType {
    var fetchPostsWasCalled = false
    var savePostsWasCalled = false
    var postsToSave: [Post] = []
    var resultToBeReturned: Result<[Post], Error>!

    func fetchPosts(completionHandler: @escaping (Result<[Post], Error>) -> Void) {
        fetchPostsWasCalled = true
        completionHandler(resultToBeReturned)
    }

    func save(posts: [Post]) {
        savePostsWasCalled = true
        postsToSave = posts
    }
}
