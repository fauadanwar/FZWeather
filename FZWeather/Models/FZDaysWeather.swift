//
//  FZDaysWeather.swift
//  FZWeather
//
//  Created by Fauad Anwar on 17/10/22.
//

import Foundation
// MARK: - FZ5DaysWeather
struct FZDaysWeather: Decodable {
    var list: [FZList]
    let dt: Date
}
extension FZDaysWeather
{
    static func daysWeatherModels() -> [FZDaysWeather]
    {
        return [FZDaysWeather(list: FZList.listModels(), dt: Date(timeIntervalSince1970: TimeInterval(1665932400))),
                FZDaysWeather(list: FZList.listModels(), dt: Date(timeIntervalSince1970: TimeInterval(1666202400)))]
    }
}
