# GHIssues
&copy; 2020 Charles Pisciotta
> A sample SwiftUI (iOS) app that allows a user to browse GitHub issues from a user's repositories.

[![Swift Version][swift-image]][swift-url]

This sample app displays a list of issues for a given repository. In the preview list, it displays basic information such as the title, #, and state of the issue.

On click, it displays a detailed view of the issue. This includes all of the previous information. In addition, it includes the following information: a description written by the owner (if applicable), the author/owner, any associated labels, the milestone associated with the issue (if applicable), an option to view comments (if applicable), and the dates when the issue was first created and last updated. 

---

<p align="center">

<img src="/Screenshots/ReposListView.png" alt="Repos List View" width="300" title="Repos List View" />

<img src="/Screenshots/IssuesListView.png" alt="Issues List View" width="300" title="Issues List View" />

<img src="/Screenshots/IssueDetailView.png" alt="Issue Detail View" width="300" title="Issue Detail View" />

</p>

---

## Features

- [x] View all issues for a given repository (10 at a time).
- [x] View a detailed description for any given issue.
- [x] View basic data, including title, description, state/status, date created/updated, author, etc.

## To Do
- [ ] SwiftUI does not have good support for automatically loading paginated requests when scrolling in a list. In the future, I'd like to determine a better way to append issues without requiring the user to click a button.
- [ ] Allow the user to filter the issues (i.e. by date created, date updated, status, author, etc.).
- [ ] Add error handling for bad requests, invalid data, slow connection, unexpected errors, etc.
- [ ] Allow the user block to see more information about the author.
- [ ] Allow the user to view comments, a milestone, and author information on an issue.
- [ ] Consider updating the issue preview to better display the issue.

---

## Development Process

**Understanding**

1. Visualize the `GET` request from a given user/organization and from a given repository using a REST client.
2. Understand the JSON being returned and understand the different scenarios from GitHub Docs.

**Design Preperation**

3. Create basic sketches and prototypes of what the sample app will look like when completed.

**Development**

4. Model the GitHub issue as a Swift struct using `Codable`.
5. Develop the app's networking layer to efficiently make a `GET` request using `URLSession`.
6. Develop the view models for the list of issues and for the issue detail view.
7. Create the SwiftUI views to display the list of issues and the detail views.

**Testing**

8. Develop now, and throughtout the process, unit tests to ensure that the code is functioning properly.
9. Use the app and determine any remaining issues, bugs, or improvements.

**Documentation and Clean Up**

10. Write now, and throughout the process, documentation to help for readability and understanding.
11. Ensure that all existing code is written cleanly and efficiently.

---

## Requirements

- iOS 14.0+
- Xcode 12.0+

## Using the application

Download or clone the project to Xcode. Run the code on the simulator or a physical device.

---

## Contribute

I would love you for your contribution to this project, check the ``LICENSE`` file for more info.

## Meta

Charles Pisciotta – Freelance iOS Developer – charles.pisciotta1@gmail.com

Distributed under the MIT license. See ``LICENSE`` for more information.

[https://github.com/cpisciotta](https://github.com/cpisciotta/)

[swift-image]:https://img.shields.io/badge/swift-5.0-orange.svg
[swift-url]: https://swift.org/
[license-image]: https://img.shields.io/badge/License-MIT-blue.svg
[license-url]: LICENSE
