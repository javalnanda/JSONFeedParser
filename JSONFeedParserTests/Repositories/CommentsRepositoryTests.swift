import XCTest
@testable import JSONFeedParser

class CommentsRepositoryTests: XCTestCase {

    let commentDataTransferServiceStub = CommentDataTransferServiceStub()
    let commentsCoreDataStoreSpy = CommentsCoreDataStoreSpy()

    var sut: CommentsRepository!

    // MARK: - Set up

    override func setUp() {
        super.setUp()
        sut = CommentsRepository(dataTransferService: commentDataTransferServiceStub, commentsCoreDataStore: commentsCoreDataStoreSpy)
    }

    // MARK: - Tests
    func test_getComments_onSuccess_savesDataToCoreData() {
        let expectedComments = Comment.createCommentsArray()
        commentDataTransferServiceStub.resultToBeReturned = .success(expectedComments)

        let expectation = self.expectation(description: "Get Comments")
        var commentsReceived: [Comment]!
        sut.getComments(for: 1) { result in
            switch result {
            case .success(let comments):
                commentsReceived = comments
            case .failure(_):
                XCTFail("Should have succeeded")
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNotNil(commentsReceived)
        XCTAssertEqual(commentsReceived.first, expectedComments.first)
        XCTAssertTrue(commentsCoreDataStoreSpy.saveCommentsWasCalled, "Didn't save comments to core data")
        XCTAssertEqual(commentsCoreDataStoreSpy.commentsToSave, expectedComments, "Comments to save didn't match")
    }

    func test_getComments_onFailure_fetchesCommentsFromCoreData() {
        commentDataTransferServiceStub.resultToBeReturned = .failure(NetworkError.notConnected)
        let expectedComments = Comment.createCommentsArray()
        commentsCoreDataStoreSpy.resultToBeReturned = .success(expectedComments)

        let expectation = self.expectation(description: "Get Comments")
        var commentsReceived: [Comment]!
        sut.getComments(for: 1) { result in
            switch result {
            case .success(let comments):
                commentsReceived = comments
            case .failure(_):
                XCTFail("Should have succeeded")
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertTrue(commentsCoreDataStoreSpy.fetchCommentsWasCalled, "Didn't call fetch comments from core data")
        XCTAssertNotNil(commentsReceived)
        XCTAssertEqual(commentsReceived.first, expectedComments.first)
    }

    func test_onFailureRetrivingFromCoreData_returnsFailure() {
        commentDataTransferServiceStub.resultToBeReturned = .failure(NetworkError.notConnected)
        commentsCoreDataStoreSpy.resultToBeReturned = .failure(CoreError(message: "Core data error"))

        let expectation = self.expectation(description: "Get Comments")
        var errorReceived: Error!
        sut.getComments(for: 1) { result in
            switch result {
            case .success(_):
                XCTFail("Should have failed")
            case .failure(let error):
                errorReceived = error
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertTrue(commentsCoreDataStoreSpy.fetchCommentsWasCalled, "Didn't call fetch comments from core data")
        XCTAssertNotNil(errorReceived)
    }
}
