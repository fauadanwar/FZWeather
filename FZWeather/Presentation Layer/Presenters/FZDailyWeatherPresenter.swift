//
//  FZDailyWeatherPresenter.swift
//  FZWeather
//
//  Created by Fauad Anwar on 16/10/22.
//

import Foundation
struct FZDailyWeatherPresenter
{
    var hourlyWeatherPresenter: [FZ3HrWeatherPresenter] = []
    var daysWeather: FZDaysWeather
    var temperatureEnum: TemperatureEnum = .celsius {
        didSet {
            for i in 0..<hourlyWeatherPresenter.count {
                hourlyWeatherPresenter[i].temperatureEnum = temperatureEnum
            }
        }
    }
    
    init(daysWeather: FZDaysWeather, temperatureEnum: TemperatureEnum) {
        self.hourlyWeatherPresenter = daysWeather.list.map { FZ3HrWeatherPresenter(temperatureEnum: temperatureEnum, hourWeather: $0)}
        self.daysWeather = daysWeather
        self.temperatureEnum = temperatureEnum
    }
    
    private static var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, d - MMM - yyyy"
        return dateFormatter
    }
    
    var day: String {
        return Self.dateFormatter.string(from: daysWeather.dt)
    }
}
