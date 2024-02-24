//
//  FZRequestComponents.swift
//  FZWeather
//
//  Created by Fanwar on 24/02/24.
//

import Foundation

protocol FZRequestComponentsProtocol {
    var urlComponents: URLComponents { get }
}

extension FZRequestComponentsProtocol {
    var urlComponents: URLComponents {
        var components = URLComponents()
        components.scheme = FZEndpoints.scheme
        components.host = FZEndpoints.host
        components.path = FZEndpoints.path + "/forecast"
        
        components.queryItems = [
            URLQueryItem(name: "mode", value: "json"),
            URLQueryItem(name: "units", value: "metric"),
            URLQueryItem(name: "APPID", value: FZEndpoints.aappID)
        ]
        return components
    }
}
