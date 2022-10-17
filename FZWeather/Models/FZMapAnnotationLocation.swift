//
//  FZMapAnnotationLocation.swift
//  FZWeather
//
//  Created by Fauad Anwar on 18/10/22.
//

import Foundation
import CoreLocation

struct FZMapAnnotationLocation: Identifiable {
    let id = UUID()
    let name: String
    let coordinates: CLLocationCoordinate2D
}
