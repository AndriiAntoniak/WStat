//
//  Networking.swift
//  WarStat
//
//  Created by a.antoniak on 10.10.2023.
//

import Foundation

protocol NetworkingProtocol {
    associatedtype T: Decodable
    
    func performDataRequest(with url: URL, httpMethod: HTTPMethod) async -> Result<T, NetworkingError>
}

struct Networking<T: Decodable>: NetworkingProtocol {
    let urlSession: URLSession
    
    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    func performDataRequest(with url: URL, httpMethod: HTTPMethod = .get) async -> Result<T, NetworkingError> {
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
