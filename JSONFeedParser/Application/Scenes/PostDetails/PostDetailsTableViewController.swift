import UIKit

class PostDetailsTableViewController: UITableViewController, PostDetailsView {
	var presenter: PostDetailsPresentable!
	var configurator: PostDetailsViewConfigurable!
    var activityIndicator = UIActivityIndicatorView()

	// MARK: - IBOutlets
	@IBOutlet weak var postTitleLabel: UILabel!
	@IBOutlet weak var postBodyLabel: UILabel!

	// MARK: - UIViewController
	
	override func viewDidLoad() {
		super.viewDidLoad()
        self.title = "Post Details"
		configurator.configure(postDetailsTableViewController: self)
		presenter.viewDidLoad()
	}

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        guard let headerView = tableView.tableHeaderView else {
          return
        }
        let size = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        if headerView.frame.size.height != size.height {
            headerView.frame.size.height = size.height
            tableView.tableHeaderView = headerView
        }
    }

	// MARK: - PostDetailsView
	
	func display(title: String) {
		postTitleLabel.text = title
	}
	
	func display(body: String) {
		postBodyLabel.text = body
	}

    // MARK: - UITableViewDataSource

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfComments
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentTableViewCell", for: indexPath) as! CommentTableViewCell
        presenter.configure(cell: cell, forRow: indexPath.row)

        return cell
    }

    // MARK: - DetailsView

    func refreshCommentsView() {
        tableView.reloadData()
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
