import Foundation

struct APIEndpoints {
    static func posts() -> Endpoint<[Post]> {
        return Endpoint(path: "posts")
    }

    static func comments(for postId: Int) -> Endpoint<[Comment]> {

        return Endpoint(path: "comments",
                        queryParameters: ["postId": postId])
    }
}
