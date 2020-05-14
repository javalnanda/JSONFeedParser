import Foundation

final class CommentsRepository {

    private let dataTransferService: DataTransferService
    private let commentsCoreDataStore: CommentsCoreDataStoreType

    init(dataTransferService: DataTransferService,
         commentsCoreDataStore: CommentsCoreDataStoreType) {
        self.dataTransferService = dataTransferService
        self.commentsCoreDataStore = commentsCoreDataStore
    }
}

extension CommentsRepository: CommentsRepositoryType {
    func getComments(for postId: Int, completion: @escaping (Result<[Comment], Error>) -> Void) {
        fetchDataFromRemote(for: postId, completion: completion)
    }

    private func fetchDataFromRemote(for postId:Int, completion: @escaping (Result<[Comment], Error>) -> Void) {
        let endpoint = APIEndpoints.comments(for: postId)
       self.dataTransferService.request(with: endpoint) { [weak self] result in
            switch result {
            case .success(let comments):
                self?.commentsCoreDataStore.save(comments: comments, for: postId)
                completion(.success(comments))
            case .failure(_):
                self?.fetchCachedData(for: postId, completion: completion)
            }
        }
    }

    func fetchCachedData(for postId: Int, completion: @escaping (Result<[Comment], Error>) -> Void) {
        commentsCoreDataStore.fetchComments(for: postId) { coreDataResult in
            switch coreDataResult {
            case .success(let comments):
                comments.isEmpty ? completion(.failure(CoreError(message: "Failed retrieving comments from db"))) : completion(.success(comments))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
