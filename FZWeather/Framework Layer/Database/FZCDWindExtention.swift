//
//  FZCDWindExtention.swift
//  FZWeather
//
//  Created by Fauad Anwar on 18/10/22.
//

import Foundation
extension FZCDWind
{
    func convertToWind() -> FZWind {
        return FZWind(speed: self.speed, deg: Int(self.deg), gust: self.gust)
    }
}
