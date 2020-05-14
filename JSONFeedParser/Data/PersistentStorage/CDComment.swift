import Foundation
import CoreData

extension CDComment {
    var comment: Comment {
        return Comment(postId: Int(post?.id ?? 0),
                       id: Int(id),
                       name: name ?? "",
                       email: email ?? "",
                       body: body ?? "")
    }

    func populate(with comment: Comment, cdpost: CDPost) {
        id = Int32(comment.id)
        name = comment.name
        email = comment.email
        body = comment.body
        post = cdpost
    }
}
