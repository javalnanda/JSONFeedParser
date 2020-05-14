import Foundation
import CoreData

struct CoreError: Error {
    var localizedDescription: String {
        return message
    }

    var message = ""
}

protocol PostsCoreDataStoreType {
    func fetchPosts(completionHandler: @escaping (Result<[Post], Error>) -> Void)
    func save(posts: [Post])
}

class PostsCoreDataStore: PostsCoreDataStoreType {
    let viewContext: NSManagedObjectContextProtocol

    init(viewContext: NSManagedObjectContextProtocol) {
        self.viewContext = viewContext
    }

    func fetchPosts(completionHandler: @escaping (Result<[Post], Error>) -> Void) {
        let sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]
        if let coreDataPosts = try? viewContext.allEntities(withType: CDPost.self, predicate: nil, sortDescriptors: sortDescriptors) {
            let posts = coreDataPosts.map { $0.post }
            completionHandler(.success(posts))
        } else {
            completionHandler(.failure(CoreError(message: "Failed retrieving posts from db")))
        }
    }

    func save(posts: [Post]) {        
        for post in posts {
            let cdpost = viewContext.addEntity(withType: CDPost.self)
            cdpost?.populate(with: post)
        }
        do {
            try viewContext.save()
        } catch {

        }
    }
}
