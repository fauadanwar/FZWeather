//
//  FZ5DaysRequestComponents.swift
//  FZWeather
//
//  Created by Fauad Anwar on 17/10/22.
//

import Foundation
struct FZ5DaysRequestComponents : Encodable
{
    let lat, lon: Double
    let appid: String
}
