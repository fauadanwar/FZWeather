//
//  FZ3HrWeatherPresenter.swift
//  FZWeather
//
//  Created by Fauad Anwar on 16/10/22.
//
import Foundation
struct FZ3HrWeatherPresenter
{
    var temperatureEnum: TemperatureEnum
    var hourWeather: FZList

    private static var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        return dateFormatter
    }
    
    private static var numberFormatter: NumberFormatter {
        let numberFormatter = NumberFormatter()
        numberFormatter.maximumFractionDigits = 0
        return numberFormatter
    }
    
    private static var numberFormatter2: NumberFormatter {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .percent
        return numberFormatter
    }

    func convert(_ temp: Double) -> Double {
        switch temperatureEnum {
        case .celsius:
            return temp
        case .fahrenheit:
            return temp * 9 / 5 + 32
        }
    }
    
    var time: String {
        return Self.dateFormatter.string(from: hourWeather.dt)
    }

    var overview: String {
        hourWeather.weather[0].weatherDescription.capitalized
    }
    
    var temperature: String {
        return "🌡: \(Self.numberFormatter.string(for: convert(hourWeather.main.temp)) ?? "0")°"
    }
    
    var pop: String {

        return "💧 \(Self.numberFormatter2.string(for: hourWeather.pop) ?? "0%")"
    }
    
    var clouds: String {
        return "☁️ \(hourWeather.clouds.all)%"
    }
    
    var wind: String {
        return "🌬 \(hourWeather.wind.speed)m/s"
    }
    
    var rain: String? {
        if let rain =  hourWeather.rain?.the3H
        {
            return "🌧 \(rain)mm"
        }
        return nil
    }
    
    var snow: String? {
        if let snow = hourWeather.snow?.the3H
        {
            return "❄️ \(snow)volume"
        }
        return nil
    }
    
    var humidity: String {
        return "Humidity: \(hourWeather.main.humidity)%"
    }
    
    var lazyImagePresenter: FZLazyImagePresenter
    {
        let urlString = "https://openweathermap.org/img/wn/\(hourWeather.weather[0].icon)@2x.png"
        return FZLazyImagePresenter(imageUrl: urlString)
    }

}
