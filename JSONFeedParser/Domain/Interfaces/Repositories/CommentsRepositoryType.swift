import Foundation

protocol CommentsRepositoryType {
    func getComments(for postId:Int, completion: @escaping (Result<[Comment], Error>) -> Void)
}
