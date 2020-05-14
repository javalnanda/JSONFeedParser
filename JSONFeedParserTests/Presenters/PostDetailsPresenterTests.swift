import XCTest
@testable import JSONFeedParser

class PostDetailsPresenterTest: XCTestCase {
    let fetchCommentsUseCaseStub = FetchCommentsUseCaseStub()
    let postDetailsViewSpy = PostDetailsViewSpy()

    var sut: PostDetailsPresenter!

    // MARK: - Set up

    override func setUp() {
        super.setUp()
        sut = PostDetailsPresenter(view: postDetailsViewSpy,
                                   post: Post.createPostsArray().first!,
                                   fetchCommentsUseCase: fetchCommentsUseCaseStub)
    }

    // MARK: - Tests

    func test_viewDidLoad_success_refreshCommentsView_called() {
        // Given
        let commentsToBeReturned = Comment.createCommentsArray()
        fetchCommentsUseCaseStub.resultToBeReturned = .success(commentsToBeReturned)

        // When
        sut.viewDidLoad()

        // Then
        XCTAssertTrue(postDetailsViewSpy.refreshCommentsViewCalled, "refreshCommentsView was not called")
    }

    func test_viewDidLoad_success_numberOfComments() {
        // Given
        let expectedNumberOfComments = 5
        let commentsToBeReturned = Comment.createCommentsArray(numberOfElements: expectedNumberOfComments)
        fetchCommentsUseCaseStub.resultToBeReturned = .success(commentsToBeReturned)

        // When
        sut.viewDidLoad()

        // Then
        XCTAssertEqual(expectedNumberOfComments, sut.numberOfComments, "Number of comments mismatch")
    }

    func test_viewDidLoad_success_displaysPostData() {
        let expectedPostDetail = Post.createPostsArray().first
        let commentsToBeReturned = Comment.createCommentsArray()
        fetchCommentsUseCaseStub.resultToBeReturned = .success(commentsToBeReturned)

        // When
        sut.viewDidLoad()

        // Then
        XCTAssertEqual(postDetailsViewSpy.displayedTitle, expectedPostDetail?.title, "Post Title mismatch")
        XCTAssertEqual(postDetailsViewSpy.displayedBody, expectedPostDetail?.body, "Post Body mismatch")
    }

    func test_configureCell_has_correctData() {
           // Given
           sut.comments = Comment.createCommentsArray()
           let expectedDisplayedName = "Name 1"
            let expectedDisplayedEmail = "Email 1"
           let expectedDisplayedBody = "Body 1"

           let commentCellViewSpy = CommentsCellViewSpy()

           // When
           sut.configure(cell: commentCellViewSpy, forRow: 1)

           // Then
           XCTAssertEqual(expectedDisplayedName, commentCellViewSpy.displayedName, "The name we expected was not displayed")
           XCTAssertEqual(expectedDisplayedEmail, commentCellViewSpy.displayedEmail, "The email we expected was not displayed")
            XCTAssertEqual(expectedDisplayedBody, commentCellViewSpy.displayedBody, "The body we expected was not displayed")
       }

    func test_viewDidLoad_failure_displayCellWithErrorMessage() {
        // Given
        let errorToBeReturned = CoreError(message: "Error")
        fetchCommentsUseCaseStub.resultToBeReturned = .failure(errorToBeReturned)

        let expectedDisplayedName = "No comments to show."
        let commentCellViewSpy = CommentsCellViewSpy()
        // When
        sut.viewDidLoad()
        sut.configure(cell: commentCellViewSpy, forRow: 0)

        // Then
        XCTAssertTrue(sut.numberOfComments == 1)
        XCTAssertEqual(expectedDisplayedName, commentCellViewSpy.displayedName, "The name we expected was not displayed")
        XCTAssertTrue(commentCellViewSpy.displayedEmail.isEmpty, "The email we expected was not displayed")
        XCTAssertTrue(commentCellViewSpy.displayedBody.isEmpty, "The email we expected was not displayed")
    }
}
