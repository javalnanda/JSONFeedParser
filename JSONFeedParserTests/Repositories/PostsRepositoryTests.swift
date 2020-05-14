import XCTest
@testable import JSONFeedParser

class PostsRepositoryTests: XCTestCase {

    let postDataTransferServiceStub = PostDataTransferServiceStub()
    let postsCoreDataStoreSpy = PostsCoreDataStoreSpy()

    var sut: PostsRepository!

    // MARK: - Set up

    override func setUp() {
        super.setUp()
        sut = PostsRepository(dataTransferService: postDataTransferServiceStub, postsCoreDataStore: postsCoreDataStoreSpy)
    }

    // MARK: - Tests
    func test_getPosts_onSuccess_savesDataToCoreData() {
        let expectedPosts = Post.createPostsArray()
        postDataTransferServiceStub.resultToBeReturned = .success(expectedPosts)

        let expectation = self.expectation(description: "Get Posts")
        var postsReceived: [Post]!
        sut.getPosts { result in
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
        XCTAssertEqual(postsReceived.first, expectedPosts.first)
        XCTAssertTrue(postsCoreDataStoreSpy.savePostsWasCalled, "Didn't save posts to core data")
        XCTAssertEqual(postsCoreDataStoreSpy.postsToSave, expectedPosts, "Posts to save didn't match")
    }

    func test_getPosts_onFailure_fetchesPostsFromCoreData() {
        postDataTransferServiceStub.resultToBeReturned = .failure(NetworkError.notConnected)
        let expectedPosts = Post.createPostsArray()
        postsCoreDataStoreSpy.resultToBeReturned = .success(expectedPosts)

        let expectation = self.expectation(description: "Get Posts")
        var postsReceived: [Post]!
        sut.getPosts { result in
            switch result {
            case .success(let posts):
                postsReceived = posts
            case .failure(_):
                XCTFail("Should have succeeded")
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertTrue(postsCoreDataStoreSpy.fetchPostsWasCalled, "Didn't call fetch posts from core data")
        XCTAssertNotNil(postsReceived)
        XCTAssertEqual(postsReceived.first, expectedPosts.first)
    }

    func test_onFailureRetrivingFromCoreData_returnsFailure() {
        postDataTransferServiceStub.resultToBeReturned = .failure(NetworkError.notConnected)
        postsCoreDataStoreSpy.resultToBeReturned = .failure(CoreError(message: "Core data error"))

        let expectation = self.expectation(description: "Get Posts")
        var errorReceived: Error!
        sut.getPosts { result in
            switch result {
            case .success(_):
                XCTFail("Should have failed")
            case .failure(let error):
                errorReceived = error
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertTrue(postsCoreDataStoreSpy.fetchPostsWasCalled, "Didn't call fetch posts from core data")
        XCTAssertNotNil(errorReceived)
    }
}
