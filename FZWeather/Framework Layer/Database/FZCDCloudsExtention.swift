//
//  FZCDCloudsExtention.swift
//  FZWeather
//
//  Created by Fauad Anwar on 18/10/22.
//

import Foundation
extension FZCDClouds
{
    func convertToClouds() -> FZClouds {
        return FZClouds(all: Int(self.all))
    }
}
