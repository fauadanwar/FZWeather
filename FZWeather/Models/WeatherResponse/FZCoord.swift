//
//  FZCoord.swift
//  FZWeather
//
//  Created by Fauad Anwar on 16/10/22.
//

// MARK: - FZCoord
struct FZCoord: Decodable {
    let lat, lon: Double
}
extension FZCoord
{
    static func coordModels() -> FZCoord
    {        
        return FZCoord(lat: 18.4961, lon: 73.8724)
    }
}
