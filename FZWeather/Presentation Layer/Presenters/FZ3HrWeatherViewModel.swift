//
//  FZ3HrWeatherViewModel.swift
//  FZWeather
//
//  Created by Fauad Anwar on 16/10/22.
//
import Foundation
struct FZ3HrWeatherViewModel
{
    var system: Int
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
        let celsius = temp - 273.5
        if system == 0 {
            return celsius
        } else {
            return celsius * 9 / 5 + 32
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
    
    var lazyImageViewModel: FZLazyImageViewModel
    {
        let urlString = "https://openweathermap.org/img/wn/\(hourWeather.weather[0].icon)@2x.png"
        return FZLazyImageViewModel(imageUrl: urlString)
    }

}
