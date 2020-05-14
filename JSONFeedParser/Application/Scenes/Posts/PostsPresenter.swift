import Foundation

class PostsPresenter: PostsPresentable {
	fileprivate weak var view: PostsView?
	fileprivate let fetchPostsUseCase: FetchPostsUseCaseType
	internal let router: PostsViewRoutable
	
	var posts = [Post]()
	
	var numberOfPosts: Int {
		return posts.count
	}
	
	init(view: PostsView,
	     fetchPostsUseCase: FetchPostsUseCaseType,
	     router: PostsViewRoutable) {
		self.view = view
		self.fetchPostsUseCase = fetchPostsUseCase
		self.router = router
    }

	// MARK: - PostsPresenter
	
	func viewDidLoad() {
        view?.showIndicator()
		self.fetchPostsUseCase.execute { (result) in
			switch result {
			case let .success(posts):
				self.handlePostsReceived(posts)
			case let .failure(error):
				self.handlePostsError(error)
			}
		}
	}
	
	func configure(cell: PostCellView, forRow row: Int) {
		let post = posts[row]
		
		cell.display(title: post.title)
		cell.display(body: post.body)
	}
	
	func didSelect(row: Int) {
		let post = posts[row]
		
		router.presentDetailsView(for: post)
	}

	// MARK: - Private
	
	fileprivate func handlePostsReceived(_ posts: [Post]) {
		self.posts = posts
		view?.refreshPostsView()
        view?.hideIndicator()
	}
	
	fileprivate func handlePostsError(_ error: Error) {
		// Here we could check the error type and display a custom messages
        let errorMsg = "No posts available. Try again later"
		view?.displayPostsRetrievalError(message: errorMsg)
        view?.hideIndicator()
	}
}
