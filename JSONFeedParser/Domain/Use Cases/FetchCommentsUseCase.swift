import Foundation

protocol FetchCommentsUseCaseType {
    func execute(requestValue: FetchCommentsRequestValue, completion: @escaping (Result<[Comment], Error>) -> Void)
}

final class FetchCommentsUseCase: FetchCommentsUseCaseType {

    private let commentsRepository: CommentsRepositoryType

    init(commentsRepository: CommentsRepositoryType) {
        self.commentsRepository = commentsRepository
    }

    func execute(requestValue: FetchCommentsRequestValue, completion: @escaping (Result<[Comment], Error>) -> Void) {
        self.commentsRepository.getComments(for: requestValue.postId) {
            completion($0)
        }
    }
}

struct FetchCommentsRequestValue {
    let postId: Int
}
