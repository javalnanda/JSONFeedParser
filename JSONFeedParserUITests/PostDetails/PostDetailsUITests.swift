import XCTest

class PostDetailsUITests: UITestCase {
    func test_onNavigationToDetail_rendersPostAndCommentsData() {
        let detailsPage = routeToDetailFromPosts()

        detailsPage.validatePostIsRendered()
        detailsPage.validateCellsAreRendered()
    }

    private func routeToDetailFromPosts() -> PostDetailsPage {
        let postsPage = start().postsPage

        postsPage.navigationTitleIsVisible()
        postsPage.tapOnCell()
        app.postDetailsPage.navigationTitleIsVisible(timeout: 10)
        return app.postDetailsPage
    }
}
