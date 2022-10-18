//
//  FZCDWeatherElementExtention.swift
//  FZWeather
//
//  Created by Fauad Anwar on 18/10/22.
//

import Foundation
extension FZCDWeatherElement
{
    func convertToWeatherElement() -> FZWeatherElement {
        return FZWeatherElement(id: Int(self.id), main: self.main!, weatherDescription: self.weatherDescription!, icon: self.icon!)
    }
}
