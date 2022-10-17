//
//  FZCityWeatherRouter.swift
//  FZWeather
//
//  Created by Fauad Anwar on 13/10/22.
//

import Foundation
protocol FZCityWeatherRouterProtocol {
    var entryPoint: FZCityWeatherView? { get }
    static func setup() -> FZCityWeatherRouterProtocol
}

class FZCityWeatherRouter: FZCityWeatherRouterProtocol {
    var entryPoint: FZCityWeatherView?
    
    @MainActor static func setup() -> FZCityWeatherRouterProtocol
    {
        let router = FZCityWeatherRouter()
        let cityWeatherInteractor: FZCityWeatherInteractorProtocol = FZCityWeatherInteractor()
        let cityWeatherViewModel: FZCityWeatherViewModel = FZCityWeatherViewModel(weatherRouter: router,
                                                                                  weatherInteractor: cityWeatherInteractor)
        let cityWeatherView: FZCityWeatherView = FZCityWeatherView(viewModel: cityWeatherViewModel)
        router.entryPoint = cityWeatherView
        return router
    }
}
