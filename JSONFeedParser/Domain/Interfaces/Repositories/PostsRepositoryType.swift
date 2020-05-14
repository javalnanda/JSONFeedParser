import Foundation

protocol PostsRepositoryType {
    func getPosts(completion: @escaping (Result<[Post], Error>) -> Void)
}
