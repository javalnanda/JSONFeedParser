import Foundation
@testable import JSONFeedParser

extension Comment {
    static func createCommentsArray(numberOfElements: Int = 2) -> [Comment] {
        var comments = [Comment]()

        for i in 0..<numberOfElements {
            let comment = createComment(index: i)
            comments.append(comment)
        }

        return comments
    }

    static func createComment(index: Int = 0) -> Comment {
        return Comment(postId: 1, id: index, name: "Name \(index)", email: "Email \(index)", body: "Body \(index)")
    }
}
