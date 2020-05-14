import Foundation
import UIKit

protocol PostsViewConfigurable {
    func configure(postsTableViewController: PostsTableViewController)
}

class PostsConfigurator: PostsViewConfigurable {

    func configure(postsTableViewController: PostsTableViewController) {
        let config = ApiDataNetworkConfig(baseURL: URL(string: AppConfigurations().apiBaseURL)!)

        let apiDataNetwork = DefaultNetworkService(config: config)
        let dataTransferService = DefaultDataTransferService(with: apiDataNetwork)
        let viewContext = CoreDataStack.sharedInstance.persistentContainer.viewContext
        let postsCoreDataStore = PostsCoreDataStore(viewContext: viewContext)
        let postsRepository = PostsRepository(dataTransferService: dataTransferService, postsCoreDataStore: postsCoreDataStore)
        let useCase = FetchPostsUseCase(postsRepository: postsRepository)
        let presenter = PostsPresenter(view: postsTableViewController, fetchPostsUseCase: useCase, router: PostsViewRouter(postsTableViewController: postsTableViewController))

        postsTableViewController.presenter = presenter
    }
}
