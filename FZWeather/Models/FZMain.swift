//
//  FZMain.swift
//  FZWeather
//
//  Created by Fauad Anwar on 16/10/22.
//

// MARK: - FZMain
struct FZMain: Decodable {
    let temp, feelsLike, tempMin, tempMax: Double
    let pressure, seaLevel, grndLevel, humidity: Int
    let tempKf: Double

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
        case humidity
        case tempKf = "temp_kf"
    }
}

extension FZMain
{
    static func meinModels() -> FZMain
    {
        return FZMain(temp: 303.07, feelsLike: 304.9, tempMin: 303.07, tempMax: 303.07, pressure: 1008, seaLevel: 1008, grndLevel: 944, humidity: 55, tempKf: 0)
    }
}
