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
        // Example usage with String
        let keychainString = KeychainUtility<String>()
        keychainString.save(value: <#Add certificate key here, forKey#>: "PublicKey")
        
        let router = FZCityWeatherRouter()
        let cityWeatherInteractor: FZCityWeatherInteractorProtocol = FZCityWeatherInteractor()
        let cityWeatherPresenter: FZCityWeatherPresenter = FZCityWeatherPresenter(weatherRouter: router,
                                                                                  weatherInteractor: cityWeatherInteractor)
        let cityWeatherView: FZCityWeatherView = FZCityWeatherView(presenter: cityWeatherPresenter)
        router.entryPoint = cityWeatherView
        return router
    }
}
