//
//  FZCDCoordExtention.swift
//  FZWeather
//
//  Created by Fauad Anwar on 18/10/22.
//

import Foundation
extension FZCDCoord {
    func convertToCoord() -> FZCoord {
        return FZCoord(lat: self.lat, lon: self.lon)
    }
}
