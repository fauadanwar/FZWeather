//
//  FZCDMainExtention.swift
//  FZWeather
//
//  Created by Fauad Anwar on 18/10/22.
//

import Foundation
extension FZCDMain
{
    func convertToMain() -> FZMain {
        return FZMain(temp: self.temp, feelsLike: self.feelsLike, tempMin: self.tempMin, tempMax: self.tempMax, pressure: Int(self.pressure), seaLevel: Int(self.seaLevel), grndLevel: Int(self.grndLevel), humidity: Int(self.humidity), tempKf: self.tempKf)
    }
}
