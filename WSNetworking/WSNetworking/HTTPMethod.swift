//
//  HTTPMethod.swift
//  WarStat
//
//  Created by a.antoniak on 10.10.2023.
//

import Foundation

/// Public enumeration with all possible http methods.
public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case patch = "PATCH"
    case put = "PUT"
    case delete = "DELETE"
}
