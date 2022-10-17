//
//  FZWind.swift
//  FZWeather
//
//  Created by Fauad Anwar on 16/10/22.
//

// MARK: - FZWind
struct FZWind: Decodable {
    let speed: Double
    let deg: Int
    let gust: Double
}
extension FZWind
{
    static func windModels() -> FZWind
    {
        return FZWind(speed: 2.36, deg: 83, gust: 4.37)
    }
}
