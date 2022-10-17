//
//  FZCityWeatherViewModel.swift
//  FZWeather
//
//  Created by Fauad Anwar on 13/10/22.
//

import SwiftUI

@MainActor class FZCityWeatherViewModel: ObservableObject
{
    var weatherRouter: FZCityWeatherRouterProtocol?
    var weatherInteractor: FZCityWeatherInteractorProtocol?

    struct AppError: Identifiable {
        let id = UUID().uuidString
        let errorString: String
    }
    @Published var appError: AppError? = nil
    @Published var dailyWeatherViewModel: [FZDailyWeatherViewModel] = []
    var cityViewModel: FZCityViewModel?
    @Published var isLoading: Bool = false
    @AppStorage("location") var storageLocation: String = ""
    @Published var location = ""
    @AppStorage("system") var system: Int = 0 {
        didSet {
            for i in 0..<dailyWeatherViewModel.count {
                dailyWeatherViewModel[i].system = system
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
            dailyWeatherViewModel = []
        } else {
            isLoading = true
            weatherInteractor?.getWeather(location: location, completion: { [weak self] (result: Result<FZ5DaysWeather, FZWeatherError>) in
                switch result {
                case .success(let daysWeather):
                    DispatchQueue.main.async {
                        self?.isLoading = false
                        if let location = self?.location, location.count > 0 {
                            self?.cityViewModel = FZCityViewModel(city: daysWeather.city, name: location)
                        }
                        self?.dailyWeatherViewModel = daysWeather.daysWeather.map { FZDailyWeatherViewModel(daysWeather: $0, system: self?.system ?? 0)}
                    }
                case .failure(let weatherError):
                    switch weatherError {
                    case .error(let errorString):
                        self?.isLoading = false
                        self?.appError = AppError(errorString: errorString)
                    }
                }
            })
        }
    }
}
