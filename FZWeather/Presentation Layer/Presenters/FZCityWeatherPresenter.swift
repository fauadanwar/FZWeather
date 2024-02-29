//
//  FZCityWeatherPresenter.swift
//  FZWeather
//
//  Created by Fauad Anwar on 13/10/22.
//

import SwiftUI

protocol FZCityWeatherPresenterProtocol
{
    
}

@MainActor class FZCityWeatherPresenter: ObservableObject
{
    var weatherRouter: FZCityWeatherRouterProtocol?
    var weatherInteractor: FZCityWeatherInteractorProtocol?
    
    struct AppError: Identifiable {
        let id = UUID().uuidString
        let errorString: String
    }
    @Published var appError: AppError? = nil
    @Published var dailyWeatherPresenter: [FZDailyWeatherPresenter] = []
    var cityPresenter: FZCityPresenter?
    @Published var isLoading: Bool = false
    @AppStorage("location") var storageLocation: String = ""
    @AppStorage("user location") var userLocation: String = ""
    @Published var location = ""
    
    @AppStorage("system") var temperatureEnum: TemperatureEnum = .celsius {
        didSet {
            for i in 0..<dailyWeatherPresenter.count {
                dailyWeatherPresenter[i].temperatureEnum = temperatureEnum
            }
        }
    }
    
    init(weatherRouter: FZCityWeatherRouterProtocol? = nil,
         weatherInteractor: FZCityWeatherInteractorProtocol? = nil)
    {
        self.weatherRouter = weatherRouter
        self.weatherInteractor = weatherInteractor
        self.location = storageLocation
        self.getWeather()
    }
    
    func getWeather() {
        storageLocation = location
        UIApplication.shared.endEditing()
        if location == "" {
            dailyWeatherPresenter = []
            cityPresenter = nil
            weatherInteractor?.getWeatherForUserLocation { [weak self] (result: Result<FZCityWeather, FZWeatherError>) in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let daysWeather):
                        self?.isLoading = false
                        if daysWeather.location.count > 0 {
                            self?.cityPresenter = FZCityPresenter(city: daysWeather.city, name: daysWeather.location)
                            self?.userLocation = daysWeather.location
                        }
                        self?.dailyWeatherPresenter = daysWeather.daysWeather.map { FZDailyWeatherPresenter(daysWeather: $0, temperatureEnum: self?.temperatureEnum ?? .celsius)}
                    case .failure(let weatherError):
                        switch weatherError {
                        case .error(let errorString):
                            self?.isLoading = false
                            self?.appError = AppError(errorString: errorString)
                        }
                    }
                }
            }
        } else {
            isLoading = true
            weatherInteractor?.getWeather(location: location, completion: { [weak self] (result: Result<FZCityWeather, FZWeatherError>) in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let daysWeather):
                        self?.isLoading = false
                        if daysWeather.location.count > 0 {
                            self?.cityPresenter = FZCityPresenter(city: daysWeather.city, name: daysWeather.location)
                        }
                        self?.dailyWeatherPresenter = daysWeather.daysWeather.map { FZDailyWeatherPresenter(daysWeather: $0, temperatureEnum: self?.temperatureEnum ?? .celsius)}
                    case .failure(let weatherError):
                        switch weatherError {
                        case .error(let errorString):
                            self?.isLoading = false
                            self?.appError = AppError(errorString: errorString)
                        }
                    }
                }
            })
        }
    }
}
