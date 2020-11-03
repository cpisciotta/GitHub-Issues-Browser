//
//  GHUser.swift
//  GHIssues
//
//  Created by Charles Pisciotta on 10/31/20.
//

import Foundation

struct GHUser: Codable {
    let login: String
    let userID: Int
    let nodeID: String
    let avatarURLString: String
    let gravatarID: String
    let urlString: String
    let htmlURLString: String
    let followersURLString: String
    let followingURLString: String
    let gistsURLString: String
    let starredURLString: String
    let subscriptionsURLString: String
    let organizationsURLString: String
    let reposURLString: String
    let eventsURLString: String
    let receivedEventsURLString: String
    let type: String
    let siteAdmin: Bool

    enum CodingKeys: String, CodingKey {
        case login
        case userID = "id"
        case nodeID = "node_id"
        case avatarURLString = "avatar_url"
        case gravatarID = "gravatar_id"
        case urlString = "url"
        case htmlURLString = "html_url"
        case followersURLString = "followers_url"
        case followingURLString = "following_url"
        case gistsURLString = "gists_url"
        case starredURLString = "starred_url"
        case subscriptionsURLString = "subscriptions_url"
        case organizationsURLString = "organizations_url"
        case reposURLString = "repos_url"
        case eventsURLString = "events_url"
        case receivedEventsURLString = "received_events_url"
        case type
        case siteAdmin = "site_admin"
    }
}
