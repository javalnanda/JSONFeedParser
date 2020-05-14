import Foundation

struct Post: Decodable, Equatable {
    let id: Int
    let userId: Int
    let title: String
    let body: String
}

