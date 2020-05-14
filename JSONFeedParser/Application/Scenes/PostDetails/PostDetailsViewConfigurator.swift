import Foundation

protocol PostDetailsViewConfigurable {
    func configure(postDetailsTableViewController: PostDetailsTableViewController)
}

class PostDetailsViewConfigurator: PostDetailsViewConfigurable {

    let post: Post
    init(post: Post) {
        self.post = post
    }

    func configure(postDetailsTableViewController: PostDetailsTableViewController) {
        let config = ApiDataNetworkConfig(baseURL: URL(string: AppConfigurations().apiBaseURL)!)

        let apiDataNetwork = DefaultNetworkService(config: config)
        let dataTransferService = DefaultDataTransferService(with: apiDataNetwork)
        let viewContext = CoreDataStack.sharedInstance.persistentContainer.viewContext
        let commentsCoreDataStore = CommentsCoreDataStore(viewContext: viewContext)
        let commentsRepository = CommentsRepository(dataTransferService: dataTransferService, commentsCoreDataStore: commentsCoreDataStore)
        let fetchCommentsUseCase = FetchCommentsUseCase(commentsRepository: commentsRepository)
        let presenter = PostDetailsPresenter(view: postDetailsTableViewController, post: post, fetchCommentsUseCase: fetchCommentsUseCase)

        postDetailsTableViewController.presenter = presenter
    }
}
