import Foundation
@testable import JSONFeedParser

class FetchCommentsUseCaseStub: FetchCommentsUseCaseType {
    var resultToBeReturned: Result<[Comment], Error>!

    func execute(requestValue: FetchCommentsRequestValue, completion: @escaping (Result<[Comment], Error>) -> Void) {
        completion(resultToBeReturned)
    }
}
