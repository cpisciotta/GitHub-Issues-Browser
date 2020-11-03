//
//  IssueDetailView.swift
//  GHIssues
//
//  Created by Charles Pisciotta on 10/26/20.
//

import SwiftUI

struct IssueDetailView: View {

    @ObservedObject var viewModel: GHIssueViewModel

    // Alert properties to display if an error or warning is encountered.
    @State private var displayAlert: Bool = false
    @State private var alertToDisplay: Alert?

    var body: some View {
        List {
            Section(header: Text("Important Information")) {

                Text(viewModel.title)
                    .font(.headline)

                stateRowView(state: viewModel.issueState)
            }

            Section(header: Text("Description")) {
                Group {
                    if viewModel.issueDescription.isEmpty {
                        Text("No Description Found")
                            .font(.subheadline)
                    } else {
                        Text(viewModel.issueDescription)
                            .font(.subheadline)
                    }
                }
                .padding()
            }

            Section(header: Text("Owner Information")) {
                Button(action: {
                    self.createAlert(type: .userAlert)
                }, label: {
                    simpleRowView(title: "Username", value: viewModel.ownerUsername)
                })
            }

            if !viewModel.labels.isEmpty {
                Section(header: Text("Labels")) {
                    ForEach(viewModel.labels, id: \.self) { label in
                        simpleRowView(title: label, value: "")
                    }
                }
            }

            if let milestoneTitle = viewModel.milestoneTitle {
                Section {
                    Button(action: {
                        self.createAlert(type: .milestoneAlert)
                    }, label: {
                        simpleRowView(title: "Milestone", value: milestoneTitle)
                    })
                }
            }

            if viewModel.hasComments {
                Section {
                    Button("View Comments") {
                        self.createAlert(type: .commentsAlert)
                    }
                }
            }

            Section(header: Text("Date Information")) {
                simpleRowView(title: "Date Created", value: viewModel.longDateCreatedString)
                simpleRowView(title: "Date Updated", value: viewModel.longDateUpdatedString)
            }

        }
        .listStyle(InsetGroupedListStyle())
        .navigationTitle(viewModel.issueNumberString)
        .alert(isPresented: self.$displayAlert) {
            if let alert = self.alertToDisplay {
                return alert
            }
            return Alert(title: Text("Error Encountered"))
        }
    }
}

struct IssueDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleIssue = MockData.ghSampleIssue
        let sampleVM = GHIssueViewModel(issue: sampleIssue)
        IssueDetailView(viewModel: sampleVM)
    }
}

extension IssueDetailView {
    func simpleRowView(title: String, value: String) -> some View {
        return HStack {
            Text(title)

            Spacer()

            Text(value)
                .font(.subheadline)
        }
    }

    func stateRowView(state: GHIssueViewModel.IssueStatus) -> some View {

        var stateColor: Color {
            switch state {
            case .open: return .green
            case .closed: return .red
            case .unknown: return .gray
            }
        }

        return HStack {
            Text("State")

            Spacer()

            IssueStatusIcon(status: state)

            Text(state.titleCase)
                .font(.subheadline)
                .foregroundColor(stateColor)
        }
    }
}

extension IssueDetailView {

    enum AlertType {
        case userAlert
        case milestoneAlert
        case commentsAlert

        var title: String {
            return "Upcoming Feature"
        }

        var alertDescription: String {
            switch self {
            case .userAlert:
                return "Viewing a user's profile is an upcoming feature. Stay tuned."
            case .milestoneAlert:
                return "Viewing a milestone is an upcoming feature. Stay tuned."
            case .commentsAlert:
                return "Viewing comments is an upcoming feature. Stay tuned."
            }
        }
    }

    func createAlert(type: AlertType) {
        self.displayAlert = true
        self.alertToDisplay = Alert(title: Text(type.title),
                                    message: Text(type.alertDescription),
                                    dismissButton: .default(Text("Ok")))
    }
}
