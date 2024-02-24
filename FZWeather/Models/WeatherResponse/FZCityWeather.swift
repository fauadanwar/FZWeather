//
//  FZCityWeather.swift
//  FZWeather
//
//  Created by Fauad Anwar on 17/10/22.
//

// MARK: - FZ5DaysWeather
struct FZCityWeather: Decodable {
    var daysWeather: [FZDaysWeather]
    let city: FZCity
    let location: String
}

extension FZCityWeather
{
    static func CityWeatherModels() -> FZCityWeather
    {
        return FZCityWeather(daysWeather: FZDaysWeather.daysWeatherModels(), city: FZCity.cityModels(), location: "Pune")
    }
}
