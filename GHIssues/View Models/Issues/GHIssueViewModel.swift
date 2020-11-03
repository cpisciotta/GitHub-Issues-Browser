//
//  GHIssueViewModel.swift
//  GHIssues
//
//  Created by Charles Pisciotta on 10/26/20.
//

import Foundation

class GHIssueViewModel: ObservableObject, Identifiable {

    let id = UUID()

    // MARK: Initialization
    private let issue: GHIssue
    init(issue: GHIssue) { self.issue = issue }

    // MARK: - Important Information Properties

    /// This is the title of the GitHub issue.
    var title: String { issue.title }

    /// A string representation of the GitHub issue number and the author.
    ///
    /// - Example: "Issue #31 by cpisciotta"
    var issuePreviewDetailString: String { "Issue #\(issue.number) by \(issue.user.login)" }

    /// A string representation of the `body` or description of the GitHub issue as described by the author.
    var issueDescription: String { issue.body }

    /// This indicates the status of the GitHub issue.
    ///
    /// For example, the status can be `open`, `closed`, or `unknown`.
    var issueState: IssueStatus { IssueStatus.init(rawValue: issue.state) ?? .unknown }

    /// A string reprentation of the GitHub issue number.
    ///
    /// - Example: "Issue #41"
    var issueNumberString: String { "Issue #\(issue.number)" }

    // MARK: - Date Information Properties

    private var shortDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd, ''yy"
        formatter.amSymbol = "AM"
        formatter.pmSymbol = "PM"
        return formatter
    }()

    private var longDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd, yyyy 'at' HH:mm a"
        formatter.amSymbol = "AM"
        formatter.pmSymbol = "PM"
        return formatter
    }()

    /// A Date representation of when the issue was first created.
    private var dateCreated: Date? { ISO8601DateFormatter().date(from: issue.createdAtDateString) }

    /// A long string representation of when the issue was first created.
    ///
    /// - Example: "Oct 18, 2020 at 12:32 PM"
    var longDateCreatedString: String {
        if let date = dateCreated {
            return longDateFormatter.string(from: date)
        } else {
            return "Unknown"
        }
    }

    /// A Date representation of when the issue was last updated.
    private var dateUpdated: Date? { ISO8601DateFormatter().date(from: issue.updatedAtDateString) }

    /// A long string representation of when the issue was last updated.
    ///
    /// - Example: "Oct 18, 2020 at 12:32 PM"
    var longDateUpdatedString: String {
        if let date = dateUpdated {
            return longDateFormatter.string(from: date)
        } else {
            return "Unknown"
        }
    }

    /// A short string representation of when the issue was last updated.
    ///
    /// - Example: "Oct 18, '20"
    var shortDateUpdated: String {
        if let date = dateUpdated {
            return shortDateFormatter.string(from: date)
        } else {
            return ""
        }
    }

    // MARK: - Owner Information

    /// A string representation of the author's username.
    var ownerUsername: String { issue.user.login }

    // MARK: - Label Information

    /// An array of strings representing the labels associated with the issue.
    ///
    /// For example, `bug` and `feature`.
    var labels: [String] { issue.labels.map { $0.name.capitalizingFirstLetter() } }

    // MARK: - Milestone Information

    /// An optional string representation of the milestone associated with the issue.
    var milestoneTitle: String? { issue.milestone?.title }

    /// An optional string representation
    var milestoneDescription: String? {
        if let description = issue.milestone?.milestoneDescription, description.isEmpty {
            return nil
        }
        return issue.milestone?.milestoneDescription
    }

    // MARK: - Comments Information

    /// Determines if any comments have been made on the issue.
    var hasComments: Bool { issue.comments == 0 }
}

extension GHIssueViewModel {
    /// Represents the state of the GitHub issue.
    ///
    /// For example, `open`, `closed`, or `unknown`.
    enum IssueStatus: String {
        case open
        case closed
        case unknown = "all"

        var titleCase: String {
            switch self {
            case .open: return "Open"
            case .closed: return "Closed"
            case .unknown: return "Unknown"
            }
        }
    }
}
