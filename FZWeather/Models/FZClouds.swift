//
//  FZClouds.swift
//  FZWeather
//
//  Created by Fauad Anwar on 16/10/22.
//

// MARK: - FZClouds
struct FZClouds: Decodable {
    let all: Int
}
extension FZClouds
{
    static func cloudsModels() -> FZClouds
    {
        return FZClouds(all: 100)
    }
}
