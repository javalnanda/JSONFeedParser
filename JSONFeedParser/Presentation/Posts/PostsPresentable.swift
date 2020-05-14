import Foundation

protocol PostsPresentable {
    var numberOfPosts: Int { get }
    var router: PostsViewRoutable { get }
    func viewDidLoad()
    func configure(cell: PostCellView, forRow row: Int)
    func didSelect(row: Int)
}
