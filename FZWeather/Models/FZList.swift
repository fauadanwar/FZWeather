//
//  FZList.swift
//  FZWeather
//
//  Created by Fauad Anwar on 16/10/22.
//

// MARK: - FZList
import Foundation

struct FZList: Decodable {
    let dt: Date
    let main: FZMain
    let weather: [FZWeatherElement]
    let clouds: FZClouds
    let wind: FZWind
    let visibility: Int
    let pop: Double
    let rain: FZRain?
    let snow: FZSnow?
    let sys: FZSys
    let dtTxt: String

    enum CodingKeys: String, CodingKey {
        case dt, main, weather, clouds, wind, visibility, pop, rain, snow, sys
        case dtTxt = "dt_txt"
    }
}
extension FZList
{
    static func listModels() -> [FZList]
    {
        return [FZList(dt: Date(timeIntervalSince1970: TimeInterval(1665932400)), main: FZMain.meinModels(), weather: FZWeatherElement.weatherElementModels(), clouds: FZClouds.cloudsModels(), wind: FZWind.windModels(), visibility: 10000, pop: 0.34, rain: FZRain.rainModels(), snow: FZSnow.snowModels(), sys: FZSys.sysModels(), dtTxt: "2022-10-16 15:00:00"),
                FZList(dt: Date(timeIntervalSince1970: TimeInterval(1665943200)), main: FZMain.meinModels(), weather: FZWeatherElement.weatherElementModels(), clouds: FZClouds.cloudsModels(), wind: FZWind.windModels(), visibility: 8696, pop: 0.9, rain: FZRain.rainModels(), snow: FZSnow.snowModels(), sys: FZSys.sysModels(), dtTxt: "2022-10-17 21:00:00")]
    }
}
