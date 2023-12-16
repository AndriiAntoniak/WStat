//
//  WarInfoNetworking.swift
//  WarStat
//
//  Created by a.antoniak on 10.10.2023.
//

import Foundation
import WSNetworking

typealias InfoResult = Result<WarInfoDTO, WarInfoError>

protocol WarInfoNetworkingProtocol {
    static func loadInfo() async -> InfoResult
}

// TODO: - Struct or Class
enum WarInfoNetworking {
    static func loadInfo() async -> InfoResult {
        guard let infoURL = WarInfoURL.info.url else {
            return .failure(.requestFailed)
        }
        return await Networking()
            .performDataRequest(with: infoURL)
            .mapError { networkingError in
                WarInfoError.requestFailed
        }
    }
}

enum WarInfoError: Error {
    case requestFailed
}
