//
//  FZRequestComponentsFromCity.swift
//  FZWeather
//
//  Created by Fanwar on 24/02/24.
//

import Foundation

struct FZRequestComponentsFromCity : Encodable, FZRequestComponentsProtocol
{
    let city: String

    var urlComponentsFromCity: URLComponents {
        var components = urlComponents
        components.queryItems?.append(contentsOf: [
            URLQueryItem(name: "q", value: city),
        ])
        return components
    }
}
