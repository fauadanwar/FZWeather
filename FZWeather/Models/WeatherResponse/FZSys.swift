//
//  FZSys.swift
//  FZWeather
//
//  Created by Fauad Anwar on 16/10/22.
//

// MARK: - FZSys
struct FZSys: Decodable {
    let pod: String
}
extension FZSys
{
    static func sysModels() -> FZSys
    {
        return FZSys(pod: "d")
    }
}
