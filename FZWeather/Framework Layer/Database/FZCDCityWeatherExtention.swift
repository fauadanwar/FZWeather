//
//  FZCDCityWeatherExtention.swift
//  FZWeather
//
//  Created by Fauad Anwar on 18/10/22.
//

import Foundation
extension FZCDCityWeather {
    func convertToCityWeather() -> FZCityWeather {
        var daysWeatherArray = [FZDaysWeather]()
        for daysWeather in self.toDaysWeather! {
            if let daysWeather = daysWeather as? FZCDDaysWeather
            {
                daysWeatherArray.append(daysWeather.convertToDaysWeather())
            }
        }
        return FZCityWeather(daysWeather: daysWeatherArray, city: self.toCity!.convertToCity(), location: self.location!)
    }
    
    func convertToCDCityWeather(cityWeather: FZCityWeather) {
        self.location = cityWeather.location
    }
}
