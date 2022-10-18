//
//  FZCDSysExtention.swift
//  FZWeather
//
//  Created by Fauad Anwar on 18/10/22.
//

import Foundation
extension FZCDSys
{
    func convertToSys() -> FZSys {
        return FZSys(pod: self.pod!)
    }
}
