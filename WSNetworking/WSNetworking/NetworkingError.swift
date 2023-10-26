//
//  NetworkingError.swift
//  WarStat
//
//  Created by a.antoniak on 10.10.2023.
//

import Foundation

public enum NetworkingError: Error {
    case decodingFailed
    case cannotConstructUrl
    case requestFailed
}
