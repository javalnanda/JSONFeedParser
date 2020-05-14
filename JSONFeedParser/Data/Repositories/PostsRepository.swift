import Foundation

final class PostsRepository {

    private let dataTransferService: DataTransferService
    private let postsCoreDataStore: PostsCoreDataStoreType

    init(dataTransferService: DataTransferService,
         postsCoreDataStore: PostsCoreDataStoreType) {
        self.dataTransferService = dataTransferService
        self.postsCoreDataStore = postsCoreDataStore
    }
}

extension PostsRepository: PostsRepositoryType {
    func getPosts(completion: @escaping (Result<[Post], Error>) -> Void) {
        fetchDataFromRemote(completion: completion)
    }

    private func fetchDataFromRemote(completion: @escaping (Result<[Post], Error>) -> Void) {
        let endpoint = APIEndpoints.posts()
        self.dataTransferService.request(with: endpoint) { [weak self] result in
            switch result {
            case .success(let posts):
                self?.postsCoreDataStore.save(posts: posts)
                completion(.success(posts))
            case .failure(_):
                self?.fetchCachedData(completion: completion)
            }
        }
    }

    private func fetchCachedData(completion: @escaping (Result<[Post], Error>) -> Void) {
        self.postsCoreDataStore.fetchPosts { coreDataResult in
            switch coreDataResult {
            case .success(let posts):
                posts.isEmpty ? completion(.failure(CoreError(message: "Failed retrieving posts from db"))) : completion(.success(posts))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
