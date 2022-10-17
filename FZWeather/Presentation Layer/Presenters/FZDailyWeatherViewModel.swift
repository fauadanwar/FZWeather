//
//  FZDailyWeatherViewModel.swift
//  FZWeather
//
//  Created by Fauad Anwar on 16/10/22.
//

import Foundation
struct FZDailyWeatherViewModel
{
    var hourlyWeatherViewModel: [FZ3HrWeatherViewModel] = []
    var daysWeather: FZDaysWeather
    var system: Int = 0 {
        didSet {
            for i in 0..<hourlyWeatherViewModel.count {
                hourlyWeatherViewModel[i].system = system
            }
        }
    }
    
    init(daysWeather: FZDaysWeather, system: Int) {
        self.hourlyWeatherViewModel = daysWeather.list.map { FZ3HrWeatherViewModel(system: system, hourWeather: $0)}
        self.daysWeather = daysWeather
        self.system = system
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
