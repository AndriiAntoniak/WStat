//
//  Networking.swift
//  WarStat
//
//  Created by a.antoniak on 10.10.2023.
//

import Foundation

public protocol NetworkingProtocol {
    associatedtype T: Decodable
    
    func performDataRequest(with url: URL, httpMethod: HTTPMethod) async -> Result<T, NetworkingError>
}

public struct Networking<T: Decodable>: NetworkingProtocol {
    private let urlSession: URLSession
    
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
