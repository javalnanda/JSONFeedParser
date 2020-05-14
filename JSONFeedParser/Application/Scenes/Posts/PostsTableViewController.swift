import UIKit

class PostsTableViewController: UITableViewController, PostsView {
	var presenter: PostsPresentable!
    var configurator = PostsConfigurator()
    var activityIndicator = UIActivityIndicatorView()
    var errorMsgLabel: UILabel?

	override func viewDidLoad() {
		super.viewDidLoad()
        self.title = "Posts"
        configurator.configure(postsTableViewController: self)
		presenter.viewDidLoad()
	}
	

	// MARK: - UITableViewDataSource
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return presenter.numberOfPosts
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "PostTableViewCell", for: indexPath) as! PostTableViewCell
		presenter.configure(cell: cell, forRow: indexPath.row)
		
		return cell
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		presenter.didSelect(row: indexPath.row)
	}
	
	// MARK: - PostsView
	
	func refreshPostsView() {
        errorMsgLabel?.removeFromSuperview()
		tableView.reloadData()
	}
	
	func displayPostsRetrievalError(message: String) {
        let errorMsgLabel = UILabel(frame: self.view.frame)
        errorMsgLabel.center = self.view.center
        errorMsgLabel.textAlignment = .center
        errorMsgLabel.text = message
        errorMsgLabel.lineBreakMode = .byWordWrapping
        errorMsgLabel.numberOfLines = 0
        self.errorMsgLabel = errorMsgLabel
        self.view.addSubview(errorMsgLabel)
	}

    func showIndicator() {
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        self.view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }

    func hideIndicator() {
        activityIndicator.stopAnimating()
    }
}
