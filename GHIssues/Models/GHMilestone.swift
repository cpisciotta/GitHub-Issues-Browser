//
//  GHMilestone.swift
//  GHIssues
//
//  Created by Charles Pisciotta on 11/3/20.
//

import Foundation

struct GHMilestone: Codable {
    let urlString: String
    let htmlURLString: String
    let labelsURLString: String
    let milestoneID: Int
    let nodeID: String
    let number: Int
    let title: String
    let milestoneDescription: String
    let creator: GHUser
    let openIssues: Int
    let closedIssues: Int
    let state: String
    let createdAtDateString: String
    let updatedAtDateString: String
    let dueOnDateString: String?
    let closedAtDateString: String?

    enum CodingKeys: String, CodingKey {
        case urlString = "url"
        case htmlURLString = "html_url"
        case labelsURLString = "labels_url"
        case milestoneID = "id"
        case nodeID = "node_id"
        case number
        case title
        case milestoneDescription = "description"
        case creator
        case openIssues = "open_issues"
        case closedIssues = "closed_issues"
        case state
        case createdAtDateString = "created_at"
        case updatedAtDateString = "updated_at"
        case dueOnDateString = "due_on"
        case closedAtDateString = "closed_at"
    }
}
