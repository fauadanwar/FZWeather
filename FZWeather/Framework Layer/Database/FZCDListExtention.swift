//
//  FZCDListExtention.swift
//  FZWeather
//
//  Created by Fauad Anwar on 18/10/22.
//

import Foundation
extension FZCDList {
    func convertToList() -> FZList {
        var weathereElementArray = [FZWeatherElement]()
        for weathereElement in self.toWeatherElement! {
            if let weathereElement = weathereElement as? FZCDWeatherElement
            {
                weathereElementArray.append(weathereElement.convertToWeatherElement())
            }
        }
        return FZList(dt: self.dt!, main: self.toMain!.convertToMain(), weather: weathereElementArray, clouds: self.toClouds!.convertToClouds(), wind: self.toWind!.convertToWind(), visibility: Int(self.visibility), pop: self.pop, rain: self.toRain?.convertToRain(), snow: self.toSnow?.convertToSnow(), sys: self.toSys!.convertToSys(), dtTxt: self.dtTxt!)
    }
}
