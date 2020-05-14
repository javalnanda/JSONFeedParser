import XCTest
@testable import JSONFeedParser

class PostsPresenterTest: XCTestCase {
    let fetchPostsUseCaseStub = FetchPostsUseCaseStub()
    let postsViewRouterSpy = PostsViewRouterSpy()
    let postsViewSpy = PostsViewSpy()

    var sut: PostsPresenter!

    // MARK: - Set up

    override func setUp() {
        super.setUp()
        sut = PostsPresenter(view: postsViewSpy,
                             fetchPostsUseCase: fetchPostsUseCaseStub,
                             router: postsViewRouterSpy)
    }

    // MARK: - Tests

    func test_viewDidLoad_success_refreshPostsView_called() {
        // Given
        let postsToBeReturned = Post.createPostsArray()
        fetchPostsUseCaseStub.resultToBeReturned = .success(postsToBeReturned)

        // When
        sut.viewDidLoad()

        // Then
        XCTAssertTrue(postsViewSpy.refreshPostsViewCalled, "refreshPostsView was not called")
    }

    func test_viewDidLoad_success_numberOfPosts() {
        // Given
        let expectedNumberOfPosts = 5
        let postsToBeReturned = Post.createPostsArray(numberOfElements: expectedNumberOfPosts)
        fetchPostsUseCaseStub.resultToBeReturned = .success(postsToBeReturned)

        // When
        sut.viewDidLoad()

        // Then
        XCTAssertEqual(expectedNumberOfPosts, sut.numberOfPosts, "Number of posts mismatch")
    }

    func test_viewDidLoad_failure_displayPostsRetrievalError() {
        // Given
        let errorToBeReturned = CoreError(message: "Error")
        fetchPostsUseCaseStub.resultToBeReturned = .failure(errorToBeReturned)

        // When
        sut.viewDidLoad()

        
        // Then
        XCTAssertFalse(postsViewSpy.displayPostsRetrievalErrorMessage.isEmpty, "Error message shouldn't be empty")
    }

    func test_configureCell_has_correctData() {
        // Given
        sut.posts = Post.createPostsArray()
        let expectedDisplayedTitle = "Title 1"
        let expectedDisplayedBody = "Body 1"

        let postCellViewSpy = PostCellViewSpy()

        // When
        sut.configure(cell: postCellViewSpy, forRow: 1)

        // Then
        XCTAssertEqual(expectedDisplayedTitle, postCellViewSpy.displayedTitle, "The title we expected was not displayed")
        XCTAssertEqual(expectedDisplayedBody, postCellViewSpy.displayedBody, "The body we expected was not displayed")
    }

    func test_didSelect_navigates_to_details_view() {
        // Given
        let posts = Post.createPostsArray()
        let rowToSelect = 1
        sut.posts = posts

        // When
        sut.didSelect(row: rowToSelect)

        // Then
        XCTAssertEqual(posts[rowToSelect], postsViewRouterSpy.passedPost, "Expected navigate to details view to be called with post at index 1")
    }

}


