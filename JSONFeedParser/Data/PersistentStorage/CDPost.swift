import Foundation
import CoreData

extension CDPost {
    var post: Post {
        return Post(id: Int(id),
                    userId: Int(userId),
                    title: title ?? "",
                    body: body ?? "")
    }

    func populate(with post: Post) {
        id = Int32(post.id)
        userId = Int32(post.userId)
        title = post.title
        body = post.body
    }
}
