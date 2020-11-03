//
//  GHRepoListViewModel.swift
//  GHIssues
//
//  Created by Charles Pisciotta on 11/2/20.
//

import SwiftUI

class GHRepoListViewModel: ObservableObject {

    private var repositories: [GHRepoViewModel]? {
        willSet {
            self.objectWillChange.send()
        }
    }

    var reposToShow: [GHRepoViewModel]? {
        repositories?.filter({ repoVM in
            if self.showReposWithIssuesOnly {
                return repoVM.hasIssues
            } else {
                return true
            }
        })
    }

    var shouldCheckForRepos: Bool { repositories == nil && hasMore }

    @Published var showReposWithIssuesOnly: Bool = true

    // MARK: - Error Handling Properties

    @Published private (set) var error: Error?

    var hasError: Binding<Bool> {
        Binding(get: {
            self.error != nil
        }, set: { _ in
            self.error = nil
        })
    }

    // MARK: - Pagination

    /// The next page of repos that should be pulled.
    ///
    /// By default, this value is 1.
    private var page: Int = 1

    /// The maximum number of repos that should be pulled with the page.
    /// This value is set to 10.
    private let numPerPage = 10

    /// This indicates if a `GET` request should attempt to pull issues.
    ///
    /// By default, this value is true.
    ///
    /// This value is set to false when the number of elements retrieved is less than the value of `numPerPage`.
    /// Once this value is set to false, it cannot be set to `true`.
    private(set) var hasMore: Bool = true

    let username: String

    init(username: String) { self.username = username }

    // MARK: - Get Available Repositories

    func getAvailableRepositories() {

        // Check if a request is allowed.
        if self.hasMore == false { return }

        GHNetworkManager().getRepos(username: username,
                                    page: page,
                                    elementsPerPage: numPerPage) { [weak self] (result) in

            guard let self = self else { return }

            switch result {

            case .failure(let error):

                DispatchQueue.main.async {
                    self.error = error
                }

            case .success(let repos):

                // Increment the page number for the next request.
                self.page += 1

                // If the number of repos returned is less than `numPerPage`,
                // the next request would not return any new repos.
                // If the array is empty, return.
                // If some values exist, disable future requests and add the remaining repos.
                if repos.isEmpty {
                    self.hasMore = false
                } else if repos.count < self.numPerPage {
                    self.hasMore = false
                }

                DispatchQueue.main.async {
                    // Add the data to the repos array.
                    if self.repositories == nil {
                        // The issues array has not yet been initialized.
                        // Create it using the new issues that were retrieved.
                        self.repositories = repos.map(GHRepoViewModel.init)
                    } else {
                        // The repositories array has already been initialized. Append the new values to it.
                        self.repositories!.append(contentsOf: repos.map(GHRepoViewModel.init))
                    }
                }
            }
        }
    }

}
