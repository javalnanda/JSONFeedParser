import XCTest

class PostsUITests: UITestCase {
    func test_onViewLoad_rendersCell() {
        let postsPage = launchPostsScreen()

        postsPage.navigationTitleIsVisible()
        postsPage.validateCellsAreRendered()
    }

    func test_tapOnPost_routesToDetail() {
        let postsPage = launchPostsScreen()

        postsPage.navigationTitleIsVisible()
        postsPage.tapOnCell()
        app.postDetailsPage.navigationTitleIsVisible()
    }

    private func launchPostsScreen() -> PostsPage {
        return start().postsPage
    }
}
