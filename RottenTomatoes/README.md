# RottenTomatoes Box Office Demo

This is an iOS demo application for displaying the latest box office movies using the [RottenTomatoes API](http://www.rottentomatoes.com/).

Time spent: 4 hours

Completed user stories:

* [x] User can view a list of movies from Rotten Tomatoes. Poster images must be loading asynchronously.
* [x] User can view movie details by tapping on a cell
* [x] User sees loading state while waiting for movies API. You can use one of the 3rd party libraries at cocoacontrols.com.
* [x] User sees error message when there's a networking error. You may not use UIAlertView to display the error. See this screenshot for what the error message should look like: network error screenshot.
* [x] User can pull to refresh the movie list.
* [x] All images fade in (optional)
* [x] For the large poster, load the low-res image first, switch to high-res when complete (optional)
* [ ] All images should be cached in memory and disk. In other words, images load immediately upon cold start (optional).
* [ ] Customize the highlight and selection effect of the cell. (optional)
* [ ] Customize the navigation bar. (optional)
* [ ] Add a tab bar for Box Office and DVD. (optional)
* [ ] Add a search bar. (optional)

Notes:

It was insanely frustrating to do this project. The lecture only covered the extremely basic portions, and I don't have enough of an iOS background to know how anything works. I probably spent 10% - 20% of my time fighting the Xcode editor. I was able to hack this together and implement the functionality, but I have no idea if I'm doing things the right way or not - more likely I just wasted a bunch of time jamming together code snippets that aren't used correctly. Part of the reason I was excited for the CodePath program was that I thought there would be more information during the classes and solid availability of high quality resources. Instead, the course portal was full of broken links or blank pages, and I had to spend a bunch of time digging through half-baked online resources. I understand that a large part of this is self-directed, but I would have been much happier by skipping that first lecture and having the extra time to work on the project. I really hope these things are improved for future sessions.

Walkthrough of all user stories:

![Video Walkthrough](RottenTomatoes.gif)

