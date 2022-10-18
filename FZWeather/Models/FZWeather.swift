//
//  FZWeather.swift
//  FZWeather
//
//  Created by Fauad Anwar on 16/10/22.
//
import Foundation

// MARK: - FZWeather
struct FZWeather: Decodable {
    let cod: String
    let message, cnt: Int
    let list: [FZList]
    let city: FZCity
}

extension FZWeather
{
    static func weatherModels() -> FZWeather
    {
        return FZWeather(cod: "200", message: 0, cnt: 2, list: FZList.listModels(), city: FZCity.cityModels())
    }
    
    func convertToFZCityWeather(location: String) -> FZCityWeather?
    {
        var timeListArray = [FZList]()
        var dayListArray = [FZDaysWeather]()
        var curruntDay: Date?
        
        for listItem in list {
            if curruntDay == nil
            {
                curruntDay = listItem.dt
                timeListArray.append(listItem)
            }
            else if Calendar.current.isDate(listItem.dt, equalTo: curruntDay!, toGranularity: .day)
            {
                timeListArray.append(listItem)
            }
            else
            {
                dayListArray.append(FZDaysWeather(list: timeListArray, dt: curruntDay!))
                curruntDay = listItem.dt
                timeListArray = [listItem]
            }
        }
        dayListArray.append(FZDaysWeather(list: timeListArray, dt: curruntDay!))
        
        return FZCityWeather(daysWeather: dayListArray, city: self.city, location: location)
    }
}
