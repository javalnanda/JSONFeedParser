import UIKit

class PostsViewRouter: PostsViewRoutable {
	fileprivate weak var postsTableViewController: PostsTableViewController?
	fileprivate var post: Post!
	
	init(postsTableViewController: PostsTableViewController) {
		self.postsTableViewController = postsTableViewController
	}
	
	func presentDetailsView(for post: Post) {
		self.post = post
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let postDetailsTableViewController = storyboard.instantiateViewController(withIdentifier: "PostDetailsTableViewController") as! PostDetailsTableViewController
        postDetailsTableViewController.configurator = PostDetailsViewConfigurator(post: post)
        postsTableViewController?.navigationController?.pushViewController(postDetailsTableViewController, animated: true)
	}
}
