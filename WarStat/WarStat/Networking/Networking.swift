//
//  Networking.swift
//  WarStat
//
//  Created by a.antoniak on 10.10.2023.
//

import Foundation

protocol NetworkingProtocol {
    associatedtype T: Decodable
    
    static func performDataRequest(with url: URL) async -> Result<T, Error>
}

enum Networking<T: Decodable>: NetworkingProtocol {
    static func performDataRequest(with url: URL) async -> Result<T, Error> {
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return T.decode(data)
        } catch {
            return .failure(NSError())
        }
    }
}
