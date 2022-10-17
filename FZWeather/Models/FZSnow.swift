//
//  FZSnow.swift
//  FZWeather
//
//  Created by Fauad Anwar on 17/10/22.
//

// MARK: - FZSnow
struct FZSnow: Decodable {
    let the3H: Double

    enum CodingKeys: String, CodingKey {
        case the3H = "3h"
    }
}
extension FZSnow
{
    static func snowModels() -> FZSnow
    {
        return FZSnow(the3H: 24.7)
    }
}
