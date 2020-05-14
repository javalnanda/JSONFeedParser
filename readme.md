# JSONFeedParser

### Description
JSonFeedParser is built to using __MVP (Model View Presenter)__ and __Clean Architecture__ concepts.
It uses http://jsonplaceholder.typicode.com/posts url for displaying the Posts screen data
and http://jsonplaceholder.typicode.com/comments?postId=1 url for displaying the details screen data.

Application contains __Unit Tests__ for UseCases, Presenters, Repositories and basic __UI Tests__ for Posts and Detail screen.

### TODO/ Improvements

* Unit Tests for Core Data
* Custom Error Handling for specific error codes and Reachability check before hitting api request.
* Use Swifter for UITests as a mock server. I have not used it at this point as the application is only performing the GET operation and hitting the actual url also serves as an End-to-End test. Mock server is recommended when performing any operations which alters the DB.
* Can introduce Reactive framework when application grows and use other features with MVVM+Rx pattern
