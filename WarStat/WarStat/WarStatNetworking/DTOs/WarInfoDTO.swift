//
//  WarInfoDTO.swift
//  WarStat
//
//  Created by a.antoniak on 10.10.2023.
//

import Foundation

struct WarInfoDTO: Decodable {
    let message: String
    let data: WarInfoDataDTO
}
