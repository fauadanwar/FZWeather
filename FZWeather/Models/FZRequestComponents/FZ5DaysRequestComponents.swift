//
//  FZ5DaysRequestComponents.swift
//  FZWeather
//
//  Created by Fauad Anwar on 17/10/22.
//

import Foundation

struct FZRequestComponentsFromLatAndLon : Encodable, FZRequestComponentsProtocol
{
    let lat, lon: Double
    
    var urlComponentsFromLatAndLon: URLComponents {
        var components = urlComponents
        components.queryItems?.append(contentsOf: [
            URLQueryItem(name: "lat", value: String(format: "%f", lat)),
            URLQueryItem(name: "lon", value: String(format: "%f", lon)),
        ])
        return components
    }
}

