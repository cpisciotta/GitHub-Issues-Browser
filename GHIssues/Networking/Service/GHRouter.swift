//
//  GHRouter.swift
//  GHIssues
//
//  Created by Charles Pisciotta on 10/26/20.
//

import Foundation

final class GHRouter {}

extension GHRouter {
    /// This functions creates a `GET` HTTP request.
    ///
    /// - Parameters:
    ///   - route: The desired API end point to be accessed.
    ///   - completion: This completion handler holds a result with the data retrieved
    ///                 or an error after performing the request.
    func request<T: Decodable>(route: GHEndPoint, completion: @escaping (Result<T, Error>) -> Void) {

        let request = self.buildRequest(from: route)

        URLSession.shared.dataTask(with: request) { (data, _, error) in

            // If an error occurs, end the attempt.
            if let err = error {
                completion(.failure(err))
                return
            }

            // If data exists, attempt to decode it.
            // NOTE: `data` should not be nil, given that `error` was not nil.
            if let data = data {

                // Attempt to decode the data.
                // On success, pass the data to the handler.
                // On failure, pass the error to the handler.
                do {
                    let issues = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(issues))
                } catch {
                    completion(.failure(error))
                }

                return
            }

            // TODO: Add response validation in the future

            // TODO: Add more error handling in the future

            completion(.failure(NSError()))
        }.resume()
    }
}

extension GHRouter {
    /// This builds the HTTP request using the desired API end point information.
    ///
    /// - Parameter route: The desired API end point to be accessed.
    /// - Returns: The completed HTTP URLRequest.
    private func buildRequest(from route: GHEndPoint) -> URLRequest {

        let url: URL = {
            var components = URLComponents(string: route.baseURL.absoluteString)!
            components.path = route.path

            if let items = route.queryItems {
                components.queryItems = items.map({ (key, value) in
                    URLQueryItem(name: key, value: value)
                })
            }

            if let url = components.url {
                return url
            } else {
                fatalError(components.debugDescription)
            }
        }()

        var request = URLRequest(url: url)
        request.httpMethod = route.httpType.rawValue

        switch route.task {
        case .request: request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }

        return request
    }
}
