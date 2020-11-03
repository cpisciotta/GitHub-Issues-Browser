//
//  MockData.swift
//  GHIssues
//
//  Created by Charles Pisciotta on 10/26/20.
//

import Foundation

// swiftlint:disable all
struct MockData {
    static let ghSampleIssue = GHIssue(urlString: "https://api.github.com/repos/github/fetch/issues/856",
                                       repositoryURLString: "https://api.github.com/repos/github/fetch",
                                       labelsURLString: "https://api.github.com/repos/github/fetch/issues/856/labels{/name}",
                                       commentsURLString: "https://api.github.com/repos/github/fetch/issues/856/comments",
                                       eventsURLString: "https://api.github.com/repos/github/fetch/issues/856/events",
                                       htmlURLString: "https://github.com/github/fetch/issues/856",
                                       issueID: 728743600,
                                       nodeID: "MDU6SXNzdWU3Mjg3NDM2MDA=",
                                       number: 856,
                                       title: "Request body object is passed as-is",
                                       user: .init(login: "kettanaito",
                                                   userID: 14984911,
                                                   nodeID: "MDQ6VXNlcjE0OTg0OTEx",
                                                   avatarURLString: "https://avatars3.githubusercontent.com/u/14984911?v=4",
                                                   gravatarID: "",
                                                   urlString: "https://api.github.com/users/kettanaito",
                                                   htmlURLString: "https://github.com/kettanaito",
                                                   followersURLString: "https://api.github.com/users/kettanaito/followers",
                                                   followingURLString: "https://api.github.com/users/kettanaito/following{/other_user}",
                                                   gistsURLString: "https://api.github.com/users/kettanaito/gists{/gist_id}",
                                                   starredURLString: "https://api.github.com/users/kettanaito/starred{/owner}{/repo}",
                                                   subscriptionsURLString: "https://api.github.com/users/kettanaito/subscriptions",
                                                   organizationsURLString: "https://api.github.com/users/kettanaito/orgs",
                                                   reposURLString: "https://api.github.com/users/kettanaito/repos",
                                                   eventsURLString: "https://api.github.com/users/kettanaito/events{/privacy}",
                                                   receivedEventsURLString: "https://api.github.com/users/kettanaito/received_events",
                                                   type: "User",
                                                   siteAdmin: false),
                                       labels: [],
                                       state: "open",
                                       locked: false,
                                       assignee: nil,
                                       assignees: [],
                                       milestone: nil,
                                       comments: 2,
                                       createdAtDateString: "2020-10-24T08:54:02Z",
                                       updatedAtDateString: "2020-10-24T09:31:22Z",
                                       closedAtDateString: nil,
                                       authorAssociation: "NONE",
                                       activeLockReason: nil,
                                       body: "## Current behavior\r\n\r\nWhen providing a non-stringified object as a request body, `whatwg-fetch` propagates that object to `XMLHttpRequest.send()` as-is.\r\n\r\n```js\r\nfetch('/example', { \r\n  method: 'POST',\r\n  headers: {\r\n    'Content-Type': 'application/json'\r\n  },\r\n  body: { a: 1 }\r\n})\r\n```\r\n\r\n## Expected behavior\r\n\r\nExpected for this scenario to behave as native `window.fetch`, where such non-stringified request body would be transformed into the `\"[object Object]\"` string, stating that this is not a valid body per request headers.\r\n\r\n## Justification\r\n\r\nThis raises an incongruence between the polyfill and the implementation it polyfills, producing a different behavior in a browser and NodeJS for the same request issuing code. \r\n\r\n- Originated from https://github.com/mswjs/msw/issues/433\r\n\r\n## Reproduction\r\n\r\nSee this [reproduction repository](https://github.com/kettanaito/whatwg-fetch-json).",
                                       closedBy: nil,
                                       performedViaGithubApp: nil)
}
