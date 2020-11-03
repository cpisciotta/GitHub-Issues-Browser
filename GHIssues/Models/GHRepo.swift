//
//  GHRepo.swift
//  GHIssues
//
//  Created by Charles Pisciotta on 10/31/20.
//

import Foundation

// MARK: - GHRepo
struct GHRepo: Codable {
    let id: Int
    let nodeID: String
    let name: String
    let fullName: String
    let ghRepoPrivate: Bool
    let owner: GHUser
    let htmlURLString: String
    let ghRepoDescription: String?
    let fork: Bool
    let url: String
    let forksURLString: String
    let keysURLString: String
    let collaboratorsURLString: String
    let teamsURLString: String
    let hooksURLString: String
    let issueEventsURLString: String
    let eventsURLString: String
    let assigneesURLString: String
    let branchesURLString: String
    let tagsURLString: String
    let blobsURLString: String
    let gitTagsURLString: String
    let gitRefsURLString: String
    let treesURLString: String
    let statusesURLString: String
    let languagesURLString: String
    let stargazersURLString: String
    let contributorsURLString: String
    let subscribersURLString: String
    let subscriptionURLString: String
    let commitsURLString: String
    let gitCommitsURLString: String
    let commentsURLString: String
    let issueCommentURLString: String
    let contentsURLString: String
    let compareURLString: String
    let mergesURLString: String
    let archiveURLString: String
    let downloadsURLString: String
    let issuesURLString: String
    let pullsURLString: String
    let milestonesURLString: String
    let notificationsURLString: String
    let labelsURLString: String
    let releasesURLString: String
    let deploymentsURLString: String
    let createdAtDateString: String
    let updatedAtDateString: String
    let pushedAtDateString: String
    let gitURLString: String
    let sshURLString: String
    let cloneURLString: String
    let svnURLString: String
    let homepage: String?
    let size: Int
    let stargazersCount: Int
    let watchersCount: Int
    let language: String?
    let hasIssues: Bool
    let hasProjects: Bool
    let hasDownloads: Bool
    let hasWiki: Bool
    let hasPages: Bool
    let forksCount: Int
    let mirrorURLString: String?
    let archived, disabled: Bool
    let openIssuesCount: Int
    let license: License?
    let forks: Int
    let openIssues: Int
    let watchers: Int
    let defaultBranch: String

    enum CodingKeys: String, CodingKey {
        case id
        case nodeID = "node_id"
        case name
        case fullName = "full_name"
        case ghRepoPrivate = "private"
        case owner
        case htmlURLString = "html_url"
        case ghRepoDescription = "description"
        case fork, url
        case forksURLString = "forks_url"
        case keysURLString = "keys_url"
        case collaboratorsURLString = "collaborators_url"
        case teamsURLString = "teams_url"
        case hooksURLString = "hooks_url"
        case issueEventsURLString = "issue_events_url"
        case eventsURLString = "events_url"
        case assigneesURLString = "assignees_url"
        case branchesURLString = "branches_url"
        case tagsURLString = "tags_url"
        case blobsURLString = "blobs_url"
        case gitTagsURLString = "git_tags_url"
        case gitRefsURLString = "git_refs_url"
        case treesURLString = "trees_url"
        case statusesURLString = "statuses_url"
        case languagesURLString = "languages_url"
        case stargazersURLString = "stargazers_url"
        case contributorsURLString = "contributors_url"
        case subscribersURLString = "subscribers_url"
        case subscriptionURLString = "subscription_url"
        case commitsURLString = "commits_url"
        case gitCommitsURLString = "git_commits_url"
        case commentsURLString = "comments_url"
        case issueCommentURLString = "issue_comment_url"
        case contentsURLString = "contents_url"
        case compareURLString = "compare_url"
        case mergesURLString = "merges_url"
        case archiveURLString = "archive_url"
        case downloadsURLString = "downloads_url"
        case issuesURLString = "issues_url"
        case pullsURLString = "pulls_url"
        case milestonesURLString = "milestones_url"
        case notificationsURLString = "notifications_url"
        case labelsURLString = "labels_url"
        case releasesURLString = "releases_url"
        case deploymentsURLString = "deployments_url"
        case createdAtDateString = "created_at"
        case updatedAtDateString = "updated_at"
        case pushedAtDateString = "pushed_at"
        case gitURLString = "git_url"
        case sshURLString = "ssh_url"
        case cloneURLString = "clone_url"
        case svnURLString = "svn_url"
        case homepage, size
        case stargazersCount = "stargazers_count"
        case watchersCount = "watchers_count"
        case language
        case hasIssues = "has_issues"
        case hasProjects = "has_projects"
        case hasDownloads = "has_downloads"
        case hasWiki = "has_wiki"
        case hasPages = "has_pages"
        case forksCount = "forks_count"
        case mirrorURLString = "mirror_url"
        case archived, disabled
        case openIssuesCount = "open_issues_count"
        case license, forks
        case openIssues = "open_issues"
        case watchers
        case defaultBranch = "default_branch"
    }
}

// MARK: - License
struct License: Codable {
    let key: String
    let name: String
    let spdxID: String
    let url: String?
    let nodeID: String

    enum CodingKeys: String, CodingKey {
        case key, name
        case spdxID = "spdx_id"
        case url
        case nodeID = "node_id"
    }
}
