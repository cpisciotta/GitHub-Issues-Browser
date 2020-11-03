//
//  IssueStatusIcon.swift
//  GHIssues
//
//  Created by Charles Pisciotta on 10/26/20.
//

import SwiftUI

struct IssueStatusIcon: View {
    let status: GHIssueViewModel.IssueStatus

    var imageName: String {
        switch status {
        case .open: return "exclamationmark.circle.fill"
        case .closed: return "xmark.circle.fill"
        case .unknown: return "questionmark.circle.fill"
        }
    }

    var statusColor: Color {
        switch status {
        case .open: return .green
        case .closed: return .red
        case .unknown: return .gray
        }
    }

    var body: some View {
        Image(systemName: imageName)
            .foregroundColor(statusColor)

    }
}

struct IssueStatusIcon_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            IssueStatusIcon(status: .open)
            IssueStatusIcon(status: .closed)
            IssueStatusIcon(status: .unknown)
        }
    }
}
