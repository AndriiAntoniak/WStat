//
//  WarInfoDataDTO.swift
//  WarStat
//
//  Created by a.antoniak on 10.10.2023.
//

import Foundation

struct WarInfoDataDTO: Decodable {
    let startDate: String
    let endDate: String?
    let currentDay: Int
    let currentDate: String
    let status: WarStatusDTO
    
    enum CodingKeys: String, CodingKey {
        case startDate = "date_start"
        case endDate = "date_end"
        case currentDay = "current_day"
        case currentDate = "current_date"
        case status = "war_status"
    }
}
