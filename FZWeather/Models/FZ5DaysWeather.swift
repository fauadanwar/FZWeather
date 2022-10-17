//
//  FZ5DaysWeather.swift
//  FZWeather
//
//  Created by Fauad Anwar on 17/10/22.
//

// MARK: - FZ5DaysWeather
struct FZ5DaysWeather: Decodable {
    var daysWeather: [FZDaysWeather]
    let city: FZCity
}

extension FZ5DaysWeather
{
    static func days5WeatherModels() -> FZ5DaysWeather
    {
        return FZ5DaysWeather(daysWeather: FZDaysWeather.daysWeatherModels(), city: FZCity.cityModels())
    }
}
