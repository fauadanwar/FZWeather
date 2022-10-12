//
//  FZWeatherApp.swift
//  FZWeather
//
//  Created by Fauad Anwar on 12/10/22.
//

import SwiftUI

@main
struct FZWeatherApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
