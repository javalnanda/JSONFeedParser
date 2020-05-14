import Foundation
import CoreData

protocol CommentsCoreDataStoreType {
    func fetchComments(for postId: Int, completionHandler: @escaping (Result<[Comment], Error>) -> Void)
    func save(comments: [Comment], for postId: Int)
}

class CommentsCoreDataStore: CommentsCoreDataStoreType {
    let viewContext: NSManagedObjectContextProtocol

    init(viewContext: NSManagedObjectContextProtocol) {
        self.viewContext = viewContext
    }

    func fetchComments(for postId: Int, completionHandler: @escaping (Result<[Comment], Error>) -> Void) {
        let predicate = NSPredicate(format: "id==%d", postId)
        if let coreDataPosts = try? viewContext.allEntities(withType: CDPost.self, predicate: predicate, sortDescriptors: nil) {
            if let comments = coreDataPosts.first?.comments?.allObjects.map({ ($0 as! CDComment).comment }) {
                completionHandler(.success(comments))
            }
        } else {
            completionHandler(.failure(CoreError(message: "Failed retrieving comments from db")))
        }
    }

    func save(comments: [Comment], for postId: Int) {
        let predicate = NSPredicate(format: "id==%d", postId)
        if let coreDataPosts = try? viewContext.allEntities(withType: CDPost.self, predicate: predicate, sortDescriptors: nil), let firstMatchingPost = coreDataPosts.first {
            for comment in comments {
                let cdcomment = viewContext.addEntity(withType: CDComment.self)
                cdcomment?.populate(with: comment, cdpost: firstMatchingPost)
            }
        }

        do {
            try viewContext.save()
        } catch {

        }
    }
}
