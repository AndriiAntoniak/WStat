//
//  WarInfoNetworking.swift
//  WarStat
//
//  Created by a.antoniak on 10.10.2023.
//

import Foundation

typealias InfoResult = Result<WarInfoDTO, Error>

protocol WarInfoNetworkingProtocol {
    static func loadInfo() async -> InfoResult
}

// TODO: - Struct or Class
enum WarInfoNetworking {
    static func loadInfo() async -> InfoResult {
        guard let infoURL = WarInfoURL.info.url else {
            return .failure(NSError())
        }
        return await Networking.performDataRequest(with: infoURL)
        
        #warning("Remove it")
        do {
            let infoURL = try WarInfoURL.info.throwingUrl
            return await Networking.performDataRequest(with: infoURL)
        } catch {
            return .failure(error)
        }
    }
}
