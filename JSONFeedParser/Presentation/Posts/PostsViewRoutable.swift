import Foundation

protocol ViewRouter {}

protocol PostsViewRoutable: ViewRouter {
    func presentDetailsView(for post: Post)
}
