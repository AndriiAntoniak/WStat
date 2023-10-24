//
//  Decodable+Decode.swift
//  WarStat
//
//  Created by a.antoniak on 10.10.2023.
//

import Foundation

extension Decodable {
    static func decode(_ data: Data) -> Result<Self, NetworkingError> {
        do {
            let decodedObject = try JSONDecoder().decode(Self.self, from: data)
            return .success(decodedObject)
        } catch {
            return .failure(NetworkingError.decodingFailed)
        }
    }
}
