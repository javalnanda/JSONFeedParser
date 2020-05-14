import Foundation
import XCTest
@testable import JSONFeedParser

class FetchCommentsUsecaseTests: XCTestCase {

    func testFetchCommentsUseCase_whenSuccessfullyFetchesComments_returnsCorrectData() {
        let commentsRepository = CommentsRepositoryMock()
        let sut = FetchCommentsUseCase(commentsRepository: commentsRepository)

        let expectation = self.expectation(description: "Fetch Comments")
        var commentsReceived: [Comment]!
        sut.execute(requestValue: FetchCommentsRequestValue(postId: 1)) { result in
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
        XCTAssertEqual(commentsReceived.first, FetchCommentsUsecaseTests.comments.first)
    }

    func testFetchCommentsUseCase_whenNetworkIssue_returnsFailure() {
        let commentsRepository = CommentsRepositoryMock(mockFailure: true)
        let sut = FetchCommentsUseCase(commentsRepository: commentsRepository)

        let expectation = self.expectation(description: "Fetch Comments")
        var errorReceived: Error!
        sut.execute(requestValue: FetchCommentsRequestValue(postId: 1)) { result in
            switch result {
            case .success(_):
                XCTFail("Should have failed")
            case .failure(let error):
                errorReceived = error
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNotNil(errorReceived)
    }

    class CommentsRepositoryMock: CommentsRepositoryType {
        var mockFailure: Bool
        init(mockFailure: Bool = false) {
            self.mockFailure = mockFailure
        }

        func getComments(for postId: Int, completion: @escaping (Result<[Comment], Error>) -> Void) {
            mockFailure ? completion(.failure(DataTransferError.networkFailure(NetworkError.cancelled))) : completion(.success(FetchCommentsUsecaseTests.comments))
        }
    }

    static let comments: [Comment] = {
           let comment1 = Comment(postId: 1, id: 1, name: "name1", email: "email1", body: "body1")
           let comment2 = Comment(postId: 1, id: 2, name: "name2", email: "email2", body: "body2")
           return [comment1, comment2]
       }()
}
