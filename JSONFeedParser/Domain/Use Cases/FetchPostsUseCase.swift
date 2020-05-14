import Foundation

protocol FetchPostsUseCaseType {
    func execute(completion: @escaping (Result<[Post], Error>) -> Void)
}

final class FetchPostsUseCase: FetchPostsUseCaseType {

    private let postsRepository: PostsRepositoryType

    init(postsRepository: PostsRepositoryType) {
        self.postsRepository = postsRepository
    }

    func execute(completion: @escaping (Result<[Post], Error>) -> Void) {
        postsRepository.getPosts {
            completion($0)
        }
    }
}
