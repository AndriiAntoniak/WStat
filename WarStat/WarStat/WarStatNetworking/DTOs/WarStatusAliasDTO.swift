//
//  WarStatusAliasDTO.swift
//  WarStat
//
//  Created by a.antoniak on 10.10.2023.
//

import Foundation

enum WarStatusAliasDTO: String, Decodable {
    case inProgress = "in_progress"
    case armistice = "armistice"
    case won = "ukraine_won"
}
