import Foundation

class PostDetailsPresenter: PostDetailsPresentable {

	private let post: Post
	private let fetchCommentsUseCase: FetchCommentsUseCaseType
	private weak var view: PostDetailsView?
    private var isLoading = false

    var comments = [Comment]()

    var numberOfComments: Int {
        return comments.count > 0 ? comments.count : isLoading ? 0 : 1
    }

    private var noCommentsMessage: String {
        return "No comments to show."
    }

	init(view: PostDetailsView,
	     post: Post,
         fetchCommentsUseCase: FetchCommentsUseCaseType) {
		self.view = view
		self.post = post
        self.fetchCommentsUseCase = fetchCommentsUseCase
	}
	
	func viewDidLoad() {
		view?.display(title: post.title)
		view?.display(body: post.body)
        fetchComments()
	}

    func configure(cell: CommentCellView, forRow row: Int) {
        if comments.isEmpty && row == 0 {
            cell.display(name: noCommentsMessage)
        } else {
            let comment = comments[row]

            cell.display(name: comment.name)
            cell.display(email: comment.email)
            cell.display(body: comment.body)
        }
    }

    // MARK: - Private

    private func fetchComments() {
        isLoading = true
        view?.showIndicator()
        self.fetchCommentsUseCase.execute(requestValue: FetchCommentsRequestValue(postId: post.id)) { (result) in
            switch result {
            case let .success(comments):
                self.handleCommentsReceived(comments)
            case let .failure(error):
                self.handleCommentsError(error)
            }
        }
    }

    private func handleCommentsReceived(_ comments: [Comment]) {
        self.comments = comments
        view?.refreshCommentsView()
        view?.hideIndicator()
        isLoading = false
    }

    private func handleCommentsError(_ error: Error) {
        view?.refreshCommentsView()
        view?.hideIndicator()
        isLoading = false
    }
}
