//
//  FZRain.swift
//  FZWeather
//
//  Created by Fauad Anwar on 16/10/22.
//

// MARK: - FZRain
struct FZRain: Decodable {
    let the3H: Double

    enum CodingKeys: String, CodingKey {
        case the3H = "3h"
    }
}
extension FZRain
{
    static func rainModels() -> FZRain
    {
        return FZRain(the3H: 124.7)
    }
}
