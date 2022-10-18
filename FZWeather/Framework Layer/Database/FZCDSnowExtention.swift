//
//  FZCDSnowExtention.swift
//  FZWeather
//
//  Created by Fauad Anwar on 18/10/22.
//

import Foundation
extension FZCDSnow
{
    func convertToSnow() -> FZSnow {
        return FZSnow(the3H: self.the3H)
    }
}
