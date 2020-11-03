//
//  IssuesListView.swift
//  GHIssues
//
//  Created by Charles Pisciotta on 10/26/20.
//

import SwiftUI

struct IssuesListView: View {

    @ObservedObject var viewModel: GHIssuesListViewModel

    var body: some View {
        Group {
            if viewModel.issues != nil {
                issuesFoundView
            } else {
                loadingIssuesView
            }
        }
        .onAppear { if self.viewModel.issues == nil { self.viewModel.getIssues() } }
        .alert(isPresented: self.viewModel.hasError, content: {
            Alert(title: Text("An Error Occurred!"),
                  message: Text(self.viewModel.error!.localizedDescription),
                  dismissButton: .default(Text("Ok")))
        })
        .navigationTitle(viewModel.navigationBarTitle)
    }

    var loadingIssuesView: some View {
        VStack(spacing: 20) {
            ProgressView()

            Text("Looking for Issues...")
        }
    }

    var issuesFoundView: some View {
        List {
            if let issueVMs = viewModel.issues, !issueVMs.isEmpty {
                ForEach(issueVMs) { issueVM in
                    NavigationLink(
                        destination: IssueDetailView(viewModel: issueVM),
                        label: {
                            IssuePreview(viewModel: issueVM)
                        })
                }

                Section {
                    if viewModel.hasMore {
                        Button(action: {
                            self.viewModel.getIssues()
                        }, label: {
                            Text("Load More Issues")
                        })
                    } else {
                        EmptyView()
                    }
                }

            } else {
                Text("No Issues Found")
            }
        }
        .listStyle(GroupedListStyle())
    }

}

struct IssuesListView_Previews: PreviewProvider {
    static var previews: some View {
        let listViewVM = GHIssuesListViewModel(username: "cpisciotta", repositoryName: "FirebaseKit")
        return IssuesListView(viewModel: listViewVM)
    }
}
