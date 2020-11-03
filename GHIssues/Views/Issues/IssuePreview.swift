//
//  IssuePreview.swift
//  GHIssues
//
//  Created by Charles Pisciotta on 10/26/20.
//

import SwiftUI

struct IssuePreview: View {

    let viewModel: GHIssueViewModel

    var body: some View {

        VStack(alignment: .leading, spacing: 10) {
            HStack(alignment: .center, spacing: 10) {
                IssueStatusIcon(status: viewModel.issueState)
                    .font(.headline)
                    .lineLimit(1)
                    .truncationMode(.tail)

                Text(viewModel.issuePreviewDetailString)
                    .font(.subheadline)

                Spacer()

                Text(viewModel.shortDateUpdated)
                    .font(.subheadline)

            }

            Text(viewModel.title)
                .font(.headline)
                .lineLimit(3)
        }
        .padding()
    }
}

struct IssuePreview_Previews: PreviewProvider {
    static var previews: some View {
        let sampleIssue = MockData.ghSampleIssue
        let viewModel = GHIssueViewModel(issue: sampleIssue)
        return IssuePreview(viewModel: viewModel)
    }
}
