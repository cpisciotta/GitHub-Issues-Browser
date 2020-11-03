//
//  GHManager.swift
//  GHIssues
//
//  Created by Charles Pisciotta on 10/26/20.
//

import Foundation

/// This controls all of the HTTP requests that the app will make.
struct GHNetworkManager<T> {

    /// This function creates an instance of GHNetworkManager.
    public init() {}

    /// This property is used to create requests.
    private let router = GHRouter()

}

extension GHNetworkManager where T == [GHRepo] {

    func getRepos(username: String,
                  completion: @escaping (Result<[GHRepo], Error>) -> Void) {
        router.request(route: .getRepos(for: username)) { (result: Result<[GHRepo], Error>) in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let repos):
                completion(.success(repos))
            }
        }
    }

    func getRepos(username: String,
                  page: Int,
                  elementsPerPage: Int,
                  completion: @escaping (Result<[GHRepo], Error>) -> Void) {
        router.request(route: .getRepos(for: username,
                                        page: page,
                                        perPage: elementsPerPage)) { (result: Result<[GHRepo], Error>) in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let repos):
                completion(.success(repos))
            }
        }
    }

}

// MARK: - GHNetworkManager + GET [GHIssue]
//
// This extension provides `GET` requests when the requested data is type `[GHIssue]`.
extension GHNetworkManager where T == [GHIssue] {

    /// This retrieves an array of GHIssue from the issues of the specified repository.
    /// On success, the array is passed through the completion handler.
    /// Otherwise, an error is passed.
    ///
    /// - Note: From the GitHub Docs, only the first 30 elements are fetched.
    ///
    /// - Parameter completion: This holds the data retrieved after attempting a `GET` request.
    func getIssues(username: String,
                   repositoryName: String,
                   completion: @escaping (Result<[GHIssue], Error>) -> Void) {
        router.request(route: .getIssues(for: username,
                                         repositoryName: repositoryName)) { (result: Result<[GHIssue], Error>) in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let issues):
                completion(.success(issues))
            }
        }
    }

    /// This retrieves an array of GHIssue from the issues of the specified repository using pagination.
    /// On success, the array is passed through the completion handler.
    /// Otherwise, an error is passed.
    ///
    /// - Parameters:
    ///   - page: The page number to retrieve.
    ///   - elementsPerPage: The maximum number of elements that should be retrieved with the page.
    ///   - completion: This holds the data retrieved after attempting a `GET` request.
    func getIssues(username: String,
                   repositoryName: String,
                   page: Int,
                   elementsPerPage: Int,
                   completion: @escaping (Result<[GHIssue], Error>) -> Void) {
        router.request(route: .getIssues(for: username,
                                         repositoryName: repositoryName,
                                         page: page,
                                         perPage: elementsPerPage)) { (result: Result<[GHIssue], Error>) in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let issues):
                completion(.success(issues))
            }
        }
    }

}
