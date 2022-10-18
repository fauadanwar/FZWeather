//
//  FZCDRainExtention.swift
//  FZWeather
//
//  Created by Fauad Anwar on 18/10/22.
//

import Foundation
extension FZCDRain
{
    func convertToRain() -> FZRain {
        return FZRain(the3H: self.the3H)
    }
}
