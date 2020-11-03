//
//  GHIssuesListViewModel.swift
//  GHIssues
//
//  Created by Charles Pisciotta on 10/26/20.
//

import SwiftUI

class GHIssuesListViewModel: ObservableObject {

    @Published private(set) var issues: [GHIssueViewModel]?
    @Published private(set) var error: Error?

    var hasError: Binding<Bool> {
        Binding(get: {
            self.error != nil
        }, set: { _ in
            self.error = nil
        })
    }

    private let username: String
    private let repositoryName: String

    // MARK: - Pagination

    /// The next page of issues that should be pulled.
    ///
    /// By default, this value is 1.
    private var page: Int = 1

    /// The maximum number of issues that should be pulled with the page.
    /// This value is set to 10.
    private let numPerPage = 10

    /// This indicates if a `GET` request should attempt to pull issues.
    ///
    /// By default, this value is true.
    ///
    /// This value is set to false when the number of elements retrieved is less than the value of `numPerPage`.
    /// Once this value is set to false, it cannot be set to `true`.
    private(set) var hasMore: Bool = true

    var navigationBarTitle: String {
        repositoryName + " Issues"
    }

    // MARK: - Init

    init(username: String, repositoryName: String) {
        self.username = username
        self.repositoryName = repositoryName
    }

    // MARK: - Intents

    /// This makes a request for the next set of GitHub issues.
    func getIssues() {

        // Check if a request is allowed.
        if self.hasMore == false { return }

        GHNetworkManager().getIssues(username: username,
                                     repositoryName: repositoryName,
                                     page: page,
                                     elementsPerPage: numPerPage) { [weak self] (result) in

            guard let self = self else { return }

            switch result {

            case .failure(let error):

                DispatchQueue.main.async {
                    self.error = error
                }

            case .success(let issues):

                // Increment the page number for the next request.
                self.page += 1

                // If the number of issues returned is less than `numPerPage`,
                // the next request would not return any new issues.
                // If the array is empty, return.
                // If some values exist, disable future requests and add the remaining issues.
                if issues.isEmpty {
                    self.hasMore = false
                } else if issues.count < self.numPerPage {
                    self.hasMore = false
                }

                DispatchQueue.main.async {
                    // Add the data to the issues array.
                    if self.issues == nil {
                        // The issues array has not yet been initialized.
                        // Create it using the new issues that were retrieved.
                        self.issues = issues.map(GHIssueViewModel.init)
                    } else {
                        // The issues array has already been initialized. Append the new values to it.
                        self.issues!.append(contentsOf: issues.map(GHIssueViewModel.init))
                    }
                }
            }
        }
    }
}
