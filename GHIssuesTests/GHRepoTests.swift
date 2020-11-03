//
//  GHRepoTests.swift
//  GHIssuesTests
//
//  Created by Charles Pisciotta on 10/31/20.
//

import XCTest
@testable import GHIssues

class GHRepoTests: XCTestCase {

    static let timeout: TimeInterval = 2

    func testGetGHRepoWithBasicURLSession() {
        let getGHRepoExpectation = expectation(description: "Wait to get a GHRepo.")

        guard let url = URL(string: "https://api.github.com/users/vercel/repos") else {
            XCTFail("Failed to created URL from string.")
            return
        }

        let request = URLRequest(url: url)

        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                XCTFail(error.localizedDescription)
            }

            if let data = data {
                do {
                    let repo = try JSONDecoder().decode([GHRepo].self, from: data)
                    dump(repo)
                    getGHRepoExpectation.fulfill()
                } catch {
                    XCTFail(error.localizedDescription)
                }
            }
        }.resume()

        waitForExpectations(timeout: Self.timeout)
    }

    func testGetGHReposFromPersonalGitHub() {
        let getPersonalGHReposExpectation = expectation(description: "Wait to get GHRepos from personal GH.")

        let username = "cpisciotta"

        GHNetworkManager().getRepos(username: username) { (result) in
            switch result {
            case .failure(let error): XCTFail(error.localizedDescription)
            case .success(let repos):
                dump(repos)
                getPersonalGHReposExpectation.fulfill()
            }
        }

        waitForExpectations(timeout: Self.timeout)
    }

    func testGetFirstPage() {
        let exp = expectation(description: "GET first page response from GH.")

        let elemsPerPage = 10

        let username = "vercel"

        GHNetworkManager().getRepos(username: username, page: 1, elementsPerPage: elemsPerPage) { (result) in
            switch result {
            case .failure(let error): XCTFail(error.localizedDescription)
            case .success(let repos):
                XCTAssertLessThanOrEqual(repos.count,
                                         elemsPerPage,
                                         "Elements received is greater than the number of elements requested.")
                exp.fulfill()
            }
        }

        waitForExpectations(timeout: Self.timeout)
    }

}
