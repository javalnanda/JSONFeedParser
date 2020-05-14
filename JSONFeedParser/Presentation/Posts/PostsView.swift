import Foundation

protocol PostsView: class {
    func showIndicator()
    func hideIndicator()
    func refreshPostsView()
    func displayPostsRetrievalError(message: String)
}
