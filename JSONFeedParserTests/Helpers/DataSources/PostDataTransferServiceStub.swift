import Foundation
@testable import JSONFeedParser

class PostDataTransferServiceStub: DataTransferService {
    var resultToBeReturned: Result<[Post], Error>!

    func request<T, E>(with endpoint: E, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable, T == E.Response, E : ResponseRequestable {
        completion(resultToBeReturned as! Result<T, Error>)
    }
}
