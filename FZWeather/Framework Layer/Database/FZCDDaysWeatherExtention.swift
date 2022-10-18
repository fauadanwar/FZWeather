//
//  FZCDDaysWeatherExtention.swift
//  FZWeather
//
//  Created by Fauad Anwar on 18/10/22.
//

import Foundation
extension FZCDDaysWeather {
    func convertToDaysWeather() -> FZDaysWeather {
        var listArray = [FZList]()
        for list in self.toList! {
            if let list = list as? FZCDList
            {
                listArray.append(list.convertToList())
            }
        }
        return FZDaysWeather(list: listArray, dt: self.dt!)
    }
    
    func convertToCDDaysWeather(daysWeather: FZDaysWeather) {
        
    }
}
