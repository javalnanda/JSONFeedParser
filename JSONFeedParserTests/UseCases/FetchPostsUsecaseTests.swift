import XCTest
@testable import JSONFeedParser

class FetchPostsUsecaseTests: XCTestCase {

    func testListPostsUseCase_whenSuccessfullyFetchesPosts_returnsCorrectData() {
        let postsRepository = PostsRepositoryMock()
        let sut = FetchPostsUseCase(postsRepository: postsRepository)

        let expectation = self.expectation(description: "Fetch Posts")
        var postsReceived: [Post]!
        sut.execute { result in
            switch result {
            case .success(let posts):
                postsReceived = posts
            case .failure(_):
                XCTFail("Should have succeeded")
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNotNil(postsReceived)
        XCTAssertEqual(postsReceived.first, FetchPostsUsecaseTests.posts.first)
    }

    func testListPostsUseCase_whenNetworkIssue_returnsFailure() {
        let postsRepository = PostsRepositoryMock(mockFailure: true)
        let sut = FetchPostsUseCase(postsRepository: postsRepository)

        let expectation = self.expectation(description: "Fetch Posts")
        var errorReceived: Error!
        sut.execute { result in
            switch result {
            case .success(_):
                XCTFail("Should have Failed")
            case .failure(let error):
                errorReceived = error
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNotNil(errorReceived)
    }

    static let posts: [Post] = {
        let post1 = Post(id: 1, userId: 1, title: "title1", body: "body1")
        let post2 = Post(id: 2, userId: 2, title: "title2", body: "body2")
        return [post1, post2]
    }()

    class PostsRepositoryMock: PostsRepositoryType {
        var mockFailure: Bool
        init(mockFailure: Bool = false) {
            self.mockFailure = mockFailure
        }

        func getPosts(completion: @escaping (Result<[Post], Error>) -> Void) {
            mockFailure ? completion(.failure(RepositoryError.failedFetching)) : completion(.success(FetchPostsUsecaseTests.posts))
        }
    }
}

enum RepositoryError: Error {
    case failedFetching
}
