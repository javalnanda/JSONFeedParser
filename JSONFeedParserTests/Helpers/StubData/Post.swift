import Foundation
@testable import JSONFeedParser

extension Post {
    static func createPostsArray(numberOfElements: Int = 2) -> [Post] {
        var posts = [Post]()

        for i in 0..<numberOfElements {
            let post = createPost(index: i)
            posts.append(post)
        }

        return posts
    }

    static func createPost(index: Int = 0) -> Post {
        return Post(id: index, userId: index, title: "Title \(index)", body: "Body \(index)")
    }
}
