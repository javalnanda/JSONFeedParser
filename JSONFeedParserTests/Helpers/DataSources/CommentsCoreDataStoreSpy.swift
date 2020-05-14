import Foundation
@testable import JSONFeedParser

class CommentsCoreDataStoreSpy: CommentsCoreDataStoreType {
    var fetchCommentsWasCalled = false
    var saveCommentsWasCalled = false
    var commentsToSave: [Comment] = []
    var resultToBeReturned: Result<[Comment], Error>!

    func fetchComments(for postId: Int, completionHandler: @escaping (Result<[Comment], Error>) -> Void) {
        fetchCommentsWasCalled = true
        completionHandler(resultToBeReturned)
    }

    func save(comments: [Comment], for postId: Int) {
        saveCommentsWasCalled = true
        commentsToSave = comments
    }
}
