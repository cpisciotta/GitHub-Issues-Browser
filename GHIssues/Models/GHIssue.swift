//
//  GHIssue.swift
//  GHIssues
//
//  Created by Charles Pisciotta on 10/26/20.
//

import Foundation

// MARK: - GHIssue
struct GHIssue: Codable {
    let urlString: String
    let repositoryURLString: String
    let labelsURLString: String
    let commentsURLString: String
    let eventsURLString: String
    let htmlURLString: String
    let issueID: Int
    let nodeID: String
    let number: Int
    let title: String
    let user: GHUser
    let labels: [Label]
    let state: String
    let locked: Bool
    let assignee: GHUser?
    let assignees: [GHUser]
    let milestone: GHMilestone?
    let comments: Int
    let createdAtDateString: String
    let updatedAtDateString: String
    let closedAtDateString: String?
    let authorAssociation: String
    let activeLockReason: String?
    let body: String
    let closedBy: GHUser?
    let performedViaGithubApp: Bool?

    enum CodingKeys: String, CodingKey {
        case urlString = "url"
        case repositoryURLString = "repository_url"
        case labelsURLString = "labels_url"
        case commentsURLString = "comments_url"
        case eventsURLString = "events_url"
        case htmlURLString = "html_url"
        case issueID = "id"
        case nodeID = "node_id"
        case number
        case title
        case user
        case labels
        case state
        case locked
        case assignee
        case assignees
        case milestone
        case comments
        case createdAtDateString = "created_at"
        case updatedAtDateString = "updated_at"
        case closedAtDateString = "closed_at"
        case authorAssociation = "author_association"
        case activeLockReason = "active_lock_reason"
        case body
        case closedBy = "closed_by"
        case performedViaGithubApp = "performed_via_github_app"
    }
}

// MARK: - Label
extension GHIssue {
    struct Label: Codable {
        let labelID: Int
        let nodeID: String
        let urlString: String
        let name: String
        let color: String
        let labelDefault: Bool
        let labelDescription: String?

        enum CodingKeys: String, CodingKey {
            case labelID = "id"
            case nodeID = "node_id"
            case urlString = "url"
            case name
            case color
            case labelDefault = "default"
            case labelDescription = "description"
        }
    }
}
