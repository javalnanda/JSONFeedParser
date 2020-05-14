import UIKit

class CommentTableViewCell: UITableViewCell, CommentCellView {

    @IBOutlet weak var commentAuthorLabel: UILabel!
    @IBOutlet weak var commentAuthorEmailLabel: UILabel!
    @IBOutlet weak var commentBodyLabel: UILabel!

    func display(name: String) {
        commentAuthorLabel.text = name
    }

    func display(email: String) {
        commentAuthorEmailLabel.text = email
    }

    func display(body: String) {
        commentBodyLabel.text = body
    }
}
