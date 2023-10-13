//
//  WarStatusDTO.swift
//  WarStat
//
//  Created by a.antoniak on 10.10.2023.
//

import Foundation

struct WarStatusDTO: Decodable {
    let code: Int
    let alias: WarStatusAliasDTO
}
