//
//  Networking.swift
//  WarStat
//
//  Created by a.antoniak on 10.10.2023.
//

import Foundation

/// Public protocol adopted by the ``Networking`` struct.
public protocol NetworkingProtocol {
    associatedtype T: Decodable
    
    /// Performs asynchronous data url request to download the URL contents.
    ///
    /// Use this method to wait until the session finishes transferring data and receive it in a `result` instance.
    ///
    /// ```
    /// func performDataRequest(
    ///     with url: URL,
    ///     httpMethod: HTTPMethod
    /// ) async throws -> (Result<T, NetworkingError>
    /// ```
    ///
    /// - Parameters:
    ///   - url: url for the request.
    ///   - httpMethod: ``HTTPMethod`` of the url request.
    /// - Returns: An asynchronously-delivered result type that contains the URL contents as a generic decodable instance or the ``NetworkingError``.
    func performDataRequest(with url: URL, httpMethod: HTTPMethod) async -> Result<T, NetworkingError>
}

/// Public struct that conforms to the ``NetworkingProtocol`` and provides the interface to perform data `URLRequest`.
public struct Networking<T: Decodable>: NetworkingProtocol {
    private let urlSession: URLSession
    
    /// initializes the Networking object with the `urlSession` property.
    ///
    /// - Parameter urlSession: urlSession to be used for API request.
    public init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    public func performDataRequest(with url: URL, httpMethod: HTTPMethod = .get) async -> Result<T, NetworkingError> {
        // TODO: - Implement URLRequestConstructable
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpMethod.rawValue
        // TODO: - Implement handling headers
        
        do {
            let (data, _) = try await urlSession.data(for: urlRequest)
            return T.decode(data)
        } catch {
            return .failure(NetworkingError.requestFailed)
        }
    }
}
