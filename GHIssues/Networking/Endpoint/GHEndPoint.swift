//
//  GHEndPoint.swift
//  GHIssues
//
//  Created by Charles Pisciotta on 10/26/20.
//

import Foundation

/// The available APIs for the application.
enum GHAPI {
    case getRepos
    case getReposWithPagination(page: Int, perPage: Int)
    case getIssues
    case getIsssuesWithPagination(page: Int, perPage: Int)
}

/// The HTTP request type (i.e. GET, POST, ETC.)
enum HTTPType: String {
    case get
}

/// The type of HTTP task.
enum HTTPTask {
    case request
}

/// This holds all the information to access an API end point.
struct GHEndPoint {

    /// The name of the user or organization as indicated on GitHub.
    private let username: String

    /// The name of the repository as indicated on GitHub.
    private let repositoryName: String?

    /// The API endpoint that should be accessed.
    private let api: GHAPI

    public init(username: String, repositoryName: String? = nil, api: GHAPI) {
        self.username = username
        self.repositoryName = repositoryName
        self.api = api
    }
}

extension GHEndPoint {

    var baseURL: URL {
        if let url = URL(string: "https://api.github.com") {
            return url
        } else {
            fatalError("URL is not proper format!")
        }
    }

    var path: String {
        switch api {
        case .getReposWithPagination, .getRepos:
            return "/users/\(username)/repos"
        case .getIssues, .getIsssuesWithPagination:
            guard let repositoryName = repositoryName else {
                fatalError("Repository name cannot be nil")
            }

            return "/repos/\(username)/\(repositoryName)/issues"
        }

    }

    var httpType: HTTPType {
        return .get
    }

    var task: HTTPTask {
        return .request
    }

    var queryItems: [String: String]? {
        switch api {
        case .getRepos: return nil
        case .getIssues: return nil
        case .getReposWithPagination(let page, let perPage),
             .getIsssuesWithPagination(let page, let perPage):
            return ["page": "\(page)", "per_page": "\(perPage)"]
        }
    }

}
