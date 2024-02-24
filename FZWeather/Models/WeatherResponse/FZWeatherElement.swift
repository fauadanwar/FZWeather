//
//  FZWeatherElement.swift
//  FZWeather
//
//  Created by Fauad Anwar on 16/10/22.
//

// MARK: - FZWeatherElement
struct FZWeatherElement: Decodable {
    let id: Int
    let main, weatherDescription, icon: String

    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription = "description"
        case icon
    }
}
extension FZWeatherElement
{
    static func weatherElementModels() -> [FZWeatherElement]
    {
        return [FZWeatherElement(id: 500, main: "Rain", weatherDescription: "light rain", icon: "10n"),
                FZWeatherElement(id: 804, main: "Clouds", weatherDescription: "overcast clouds", icon: "04n")]
    }
}
