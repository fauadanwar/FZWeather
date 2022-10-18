//
//  FZCDCityExtention.swift
//  FZWeather
//
//  Created by Fauad Anwar on 18/10/22.
//

import Foundation

extension FZCDCity {
    
    func convertToCity() -> FZCity {
        return FZCity(id: Int(self.id), name: self.name!, coord: self.toCoord!.convertToCoord(), country: self.country!, population: Int(self.population), timezone: Int(self.timezone), sunrise: Int(self.sunrise), sunset: Int(self.sunset))
    }
    
    func convertToCDCity(city: FZCity) {
        
    }
}
