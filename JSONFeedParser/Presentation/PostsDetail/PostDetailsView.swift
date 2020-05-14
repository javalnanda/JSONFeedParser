import Foundation

protocol PostDetailsView: class {
    func display(title: String)
    func display(body: String)
    func refreshCommentsView()
    func showIndicator()
    func hideIndicator()
}
