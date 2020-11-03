//
//  GHIssuesTests.swift
//  GHIssuesTests
//
//  Created by Charles Pisciotta on 10/26/20.
//

import XCTest
@testable import GHIssues

class GHIssuesTests: XCTestCase {

    static let timeout: TimeInterval = 2

    /// Tests that a local issue as `json` can be parsed using the `GHIssue` model.
    /// This test fails if the data cannot be retrieved or decoded.
    func testGetLocalIssue() {
        if let path = Bundle.main.path(forResource: "issue", ofType: "json") {
            do {

                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                _ = try JSONDecoder().decode(GHIssue.self, from: data)
              } catch {
                XCTFail(error.localizedDescription)
              }
        }
    }

    /// Tests that the first page of issues can be pulled from GitHub
    /// This test sets the elements per page as 10.
    ///
    /// This test fails if the completion handler passes an error. It also fails if
    /// the number of elements retrieved exceeds the maximum requested amount. The
    /// last reason this test will fail is if the data is not parsed within 3 seconds.
    func testGetFirstPage() {
        let exp = expectation(description: "GET first page response from GH.")

        let elemsPerPage = 10

        let username = "vercel"
        let repoName = "next.js"

        GHNetworkManager().getIssues(username: username,
                                     repositoryName: repoName,
                                     page: 1,
                                     elementsPerPage: elemsPerPage) { (result) in
            switch result {
            case .failure(let error): XCTFail(error.localizedDescription)
            case .success(let issues):
                XCTAssertLessThanOrEqual(issues.count,
                                         elemsPerPage,
                                         "Elements received is greater than the number of elements requested.")
                exp.fulfill()
            }
        }

        waitForExpectations(timeout: Self.timeout)
    }

    /// Tests that the first 30 issues can be pulled from GitHub
    ///
    /// This test fails if the completion handler passes an error. It also fails if
    /// the number of elements retrieved exceeds 30 (from GitHub Docs). The
    /// last reason this test will fail is if the data is not parsed within 3 seconds.
    func testGetAllIssues() throws {

        let exp = expectation(description: "GET response from GH.")

        let username = "vercel"
        let repoName = "next.js"

        GHNetworkManager().getIssues(username: username, repositoryName: repoName) { (result) in
            switch result {
            case .failure(let error): XCTFail(error.localizedDescription)
            case .success(let issues):
                XCTAssertLessThanOrEqual(issues.count,
                                         30,
                                         "The number of elements, as indicated in GitHub Docs, should not exceed 30.")
                exp.fulfill()
            }
        }

        waitForExpectations(timeout: Self.timeout)
    }
}
