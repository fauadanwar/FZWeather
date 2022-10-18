//
//  FZWeatherBaseDataHandler.swift
//  FZWeather
//
//  Created by Fauad Anwar on 18/10/22.
//

import Foundation
protocol FZWeatherBaseDataHandlerProtocol {
    func getWeather(location: String, completion: @escaping (Result<FZCityWeather, FZWeatherError>) -> Void)
}
