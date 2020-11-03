//
//  RepoViewModel.swift
//  GHIssues
//
//  Created by Charles Pisciotta on 11/2/20.
//

import Foundation

class GHRepoViewModel: ObservableObject, Identifiable {

    let id = UUID()

    private let repo: GHRepo
    init(repo: GHRepo) { self.repo = repo }

    var name: String { repo.name }

    var repoDescription: String { repo.ghRepoDescription ?? "" }

    var hasIssues: Bool { repo.openIssues != 0 }
}
