//
//  FZCity.swift
//  FZWeather
//
//  Created by Fauad Anwar on 16/10/22.
//

// MARK: - FZCity
struct FZCity: Decodable {
    let id: Int
    let name: String
    let coord: FZCoord
    let country: String
    let population, timezone, sunrise, sunset: Int
}
extension FZCity
{
    static func cityModels() -> FZCity
    {        
        return FZCity(id: 8131502, name: "Satara", coord: FZCoord.coordModels(), country: "IN", population: 0, timezone: 19800, sunrise: 1665881897, sunset: 1665924100)
    }
}
