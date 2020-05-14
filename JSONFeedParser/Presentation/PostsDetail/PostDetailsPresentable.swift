import Foundation

protocol PostDetailsPresentable {
    func viewDidLoad()
    var numberOfComments: Int { get }
    func configure(cell: CommentCellView, forRow row: Int)
}
