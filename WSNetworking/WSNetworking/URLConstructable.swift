//
//  URLConstructable.swift
//  WarStat
//
//  Created by a.antoniak on 10.10.2023.
//

import Foundation

/// Public enumeration that contains url scheme oprions.
public enum URLScheme: String {
    case http
    case https
}

/// Protocol that contains requirements needed to construct the custom `URL` for the `URLRequest`.
public protocol URLConstructable {
    /// Scheme of the url.
    var scheme: URLScheme { get }
    /// Host of the url.
    var host: String { get }
    /// Path of the url.
    var path: String { get }
    
    /// The url that will be created based on the url components that may throw an error in case of failed initialization.
    var throwingUrl: URL { get throws }
    /// The optional url that will be created based on the url components.
    var url: URL? { get }
}

public extension URLConstructable {
    /// Extension of the ``URLConstructable`` protocol that returns `https` scheme type by default for every API request.
    var scheme: URLScheme { .https }
    
    /// Extension of the ``URLConstructable`` protocol that provides a default implementation for constructing the throwable URL.
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
    
    /// Extension of the ``URLConstructable`` protocol that provides a default implementation for constructing the optional URL.
    var url: URL? {
        var components = URLComponents()
        components.scheme = scheme.rawValue
        components.host = host
        components.path = path
        // TODO: - Implement handling query items
        return components.url
    }
}
