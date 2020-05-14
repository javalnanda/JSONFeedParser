import Foundation
@testable import JSONFeedParser

class FetchPostsUseCaseStub: FetchPostsUseCaseType {
    var resultToBeReturned: Result<[Post], Error>!
    func execute(completion: @escaping (Result<[Post], Error>) -> Void) {
        completion(resultToBeReturned)
    }
}
