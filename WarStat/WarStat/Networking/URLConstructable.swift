//
//  URLConstructable.swift
//  WarStat
//
//  Created by a.antoniak on 10.10.2023.
//

import Foundation

enum URLScheme: String {
    case http
    case https
}

protocol URLConstructable {
    var scheme: URLScheme { get }
    var host: String { get }
    var path: String { get }
    
    var throwingUrl: URL { get throws }
    var url: URL? { get }
}

extension URLConstructable {
    var scheme: URLScheme { .https }
    
    var throwingUrl: URL {
        get throws {
            var components = URLComponents()
            components.scheme = scheme.rawValue
            components.host = host
            components.path = path
            // TODO: - Implement handling query items
            
            guard let url = components.url else {
                throw NetworkingError.cannotConstructUrl
            }
            return url
        }
    }
    
    var url: URL? {
        var components = URLComponents()
        components.scheme = scheme.rawValue
        components.host = host
        components.path = path
        // TODO: - Implement handling query items
        return components.url
    }
}
