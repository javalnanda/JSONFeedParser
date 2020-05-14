import UIKit

class PostTableViewCell: UITableViewCell, PostCellView {
	
	@IBOutlet weak var postTitleLabel: UILabel!
	@IBOutlet weak var postBodyLabel: UILabel!
	
	func display(title: String) {
		postTitleLabel.text = title
	}
	
	func display(body: String) {
		postBodyLabel.text = body
	}
}
