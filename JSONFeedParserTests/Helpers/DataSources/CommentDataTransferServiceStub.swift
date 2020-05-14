import Foundation
@testable import JSONFeedParser

class CommentDataTransferServiceStub: DataTransferService {
    var resultToBeReturned: Result<[Comment], Error>!

    func request<T, E>(with endpoint: E, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable, T == E.Response, E : ResponseRequestable {
        completion(resultToBeReturned as! Result<T, Error>)
    }
}
