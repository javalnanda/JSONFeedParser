import Foundation

struct Comment: Decodable, Equatable {
    let postId: Int
    let id: Int
    let name: String
    let email: String
    let body: String
}
