//
//  GHEndPoint+Issues.swift
//  GHIssues
//
//  Created by Charles Pisciotta on 10/26/20.
//

import Foundation

extension GHEndPoint {

    /// This end point accesses the first 30 repositories, as indicated in the GitHub Docs,
    /// for the given GitHub user with the specified username, named `user`.
    /// - Parameter user: The username of the GitHub user who owns the desired GitHub repository.
    /// - Returns: Creates an API end point to access repositories for the given user.
    static func getRepos(for user: String) -> Self {
        GHEndPoint(username: user, api: .getRepos)
    }


    /// This end point accesses the repositories on the specified page, as indicated in the GitHub Docs,
    /// for the given user's repository, named `repositoryName`, using pagination.
    /// - Parameters:
    ///   - user: The username of the GitHub user who owns the desired GitHub repository.
    ///   - page: The page of repositories that is being requested.
    ///   - perPage: The maximum number of repositories that should be pulled.
    /// - Returns: Creates an API end point to access repositories for the given user using pagination.
    static func getRepos(for user: String, page: Int, perPage: Int) -> Self {
        GHEndPoint(username: user,
                   api: .getReposWithPagination(page: page, perPage: perPage))
    }

    /// This end point accesses the first 30 issues, as indicated in the GitHub Docs,
    /// for the given user's repository, named `repositoryName`.
    /// - Parameters:
    ///   - user: The username of the GitHub user who owns the desired GitHub repository.
    ///   - repositoryName: The name of the desired GitHub repository.
    /// - Returns: Creates an API end point to access issues for the given user and repository.
    static func getIssues(for user: String, repositoryName: String) -> Self {
        GHEndPoint(username: user, repositoryName: repositoryName, api: .getIssues)
    }

    /// This end point accesses the issues on the specified page, as indicated in the GitHub Docs,
    /// for the given user's repository, named `repositoryName`, using pagination.
    /// - Parameters:
    ///   - page: The page of issues that is being requested.
    ///   - perPage: The maximum number of issues that should be pulled.
    /// - Returns: Creates an API end point to access issues using pagination.
    static func getIssues(for user: String, repositoryName: String, page: Int, perPage: Int) -> Self {
        GHEndPoint(username: user,
                   repositoryName: repositoryName,
                   api: .getIsssuesWithPagination(page: page, perPage: perPage))
    }
}
