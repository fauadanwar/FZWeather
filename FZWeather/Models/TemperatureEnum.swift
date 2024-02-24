//
//  TemperatureEnum.swift
//  FZWeather
//
//  Created by Fanwar on 24/02/24.
//

import Foundation
import SwiftUI

enum TemperatureEnum: String, Codable, Equatable, CaseIterable {
    case celsius = "°C"
    case fahrenheit = "°F"
    
    var localizedName: LocalizedStringKey { LocalizedStringKey(rawValue) }
}
