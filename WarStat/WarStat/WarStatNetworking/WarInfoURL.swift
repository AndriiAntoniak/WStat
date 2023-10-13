//
//  WarInfoURL.swift
//  WarStat
//
//  Created by a.antoniak on 10.10.2023.
//

import Foundation

enum WarInfoURL: URLConstructable {
    case info
    case status(language: String = SupportingLanguage.en.rawValue)
    
#warning("Remove host from here")
    var host: String { "russianwarship.rip" }
    
    var path: String {
        switch self {
        case .info:
            "/api/v2/war-info"
        case .status(let language):
            Self.info.path + "/status/\(language)"
        }
    }
}

#warning("Giffy")
#warning("Throwing computed property")
