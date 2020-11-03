//
//  ReposListView.swift
//  GHIssues
//
//  Created by Charles Pisciotta on 11/2/20.
//

import SwiftUI

struct ReposListView: View {

    @ObservedObject var viewModel: GHRepoListViewModel

    var body: some View {
        Group {
            if viewModel.reposToShow == nil {
                loadingReposView
            } else {
                reposListView
            }
        }
        .onAppear { if self.viewModel.shouldCheckForRepos { self.viewModel.getAvailableRepositories() } }
        .alert(isPresented: self.viewModel.hasError, content: {
            Alert(title: Text("An Error Occurred!"),
                  message: Text(self.viewModel.error!.localizedDescription),
                  dismissButton: .default(Text("Ok")))
        })
        .navigationTitle(viewModel.username)
        .navigationBarItems(trailing:
            Toggle("Has Issues", isOn: self.$viewModel.showReposWithIssuesOnly)
        )
    }

    var reposListView: some View {
        List {
            if let repoVMs = viewModel.reposToShow, !repoVMs.isEmpty {
                ForEach(repoVMs) { repoVM in
                    NavigationLink(
                        destination: issueListView(for: repoVM.name),
                        label: {
                            VStack(alignment: .leading) {
                                Text(repoVM.name)
                                    .font(.headline)

                                Text(repoVM.repoDescription)
                                    .font(.subheadline)
                                    .lineLimit(2)
                            }
                            .padding()
                        })
                }

                Section {
                    if viewModel.hasMore {
                        Button(action: {
                            self.viewModel.getAvailableRepositories()
                        }, label: {
                            Text("Load More Repositories")
                        })
                    } else {
                        EmptyView()
                    }
                }

            } else {
                Text("No Repositories Found")
            }
        }
        .listStyle(GroupedListStyle())
    }

    var loadingReposView: some View {
        VStack(spacing: 20) {
            ProgressView()

            Text("Looking for Repos...")
        }
    }

    func issueListView(for repositoryName: String) -> some View {
        let username = viewModel.username
        let issueListVM = GHIssuesListViewModel(username: username, repositoryName: repositoryName)
        return IssuesListView(viewModel: issueListVM)
    }

}

struct ReposListView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = GHRepoListViewModel(username: "cpisciotta")
        return ReposListView(viewModel: viewModel)
    }
}
