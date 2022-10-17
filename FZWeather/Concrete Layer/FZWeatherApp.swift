//
//  FZWeatherApp.swift
//  FZWeather
//
//  Created by Fauad Anwar on 12/10/22.
//

import SwiftUI

@main
struct FZWeatherApp: App {

    var body: some Scene {
        WindowGroup {
            let weatherRouter = FZCityWeatherRouter.setup()
            weatherRouter.entryPoint
        }
    }
}
