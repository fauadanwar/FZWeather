//
//  FZ5DaysRequestComponents.swift
//  FZWeather
//
//  Created by Fauad Anwar on 17/10/22.
//

import Foundation
struct FZ5DaysRequestComponents : Encodable
{
    let lat, lon: Double
    
    func makeWeeklyForecastComponents(
    ) -> URLComponents {
      var components = URLComponents()
      components.scheme = FZEndpoints.scheme
      components.host = FZEndpoints.host
      components.path = FZEndpoints.path + "/forecast"
      
      components.queryItems = [
        URLQueryItem(name: "mode", value: "json"),
        URLQueryItem(name: "units", value: "metric"),
        URLQueryItem(name: "lat", value: String(format: "%f", lat)),
        URLQueryItem(name: "lon", value: String(format: "%f", lon)),
        URLQueryItem(name: "APPID", value: FZAPIKey.appid)
      ]
      return components
    }
}

