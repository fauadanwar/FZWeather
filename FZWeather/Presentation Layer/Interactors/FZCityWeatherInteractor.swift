//
//  FZCityWeatherInteractor.swift
//  FZWeather
//
//  Created by Fauad Anwar on 13/10/22.
//

import SwiftUI

public enum FZWeatherError: Error {
    case error(_ errorString: String)
}

protocol FZCityWeatherInteractorProtocol {
    
    func getWeather(location: String, completion: @escaping (Result<FZ5DaysWeather, FZWeatherError>) -> Void)
}

class FZCityWeatherInteractor: FZCityWeatherInteractorProtocol {
    
    func getWeather(location: String, completion: @escaping (Result<FZ5DaysWeather, FZWeatherError>) -> Void)
    {
        let geocoderUtility = FZGeocoderUtility()
        geocoderUtility.getCoordinates(location: location) { result in
            switch result {
            case .success(let coordinates):
                let lat = coordinates.latitude
                let lon = coordinates.longitude
                let apiService = FZWebServiceUtility.shared
                let forecast5Endpoint = "\(FZEndpoints.baseUrl)\(FZEndpoints.forecast5Path)"
                let daysRequestComponents = FZ5DaysRequestComponents(lat: lat, lon: lon, appid: FZEndpoints.appid)

                apiService.getJSON(urlString: forecast5Endpoint, requestQueryItems: daysRequestComponents) { (result: Result<FZWeather, FZWebServiceUtility.FZAPIError>) in
                    switch result {
                    case .success(let weather):
                        if let days5Weather = weather.convertToFZ5DaysWeather() {
                            completion(.success(days5Weather))
                        } else {
                            completion(.failure(.error(NSLocalizedString("Unable to parse response", comment: ""))))
                        }
                    case .failure(let apiError):
                        switch apiError {
                        case .error(let errorString):
                            completion(.failure(.error(errorString)))
                        }
                    }
                }
            case .failure(let geocoderError):
                switch geocoderError {
                case .error(let errorString):
                    completion(.failure(.error(errorString)))
                }
            }
        }
    }
}
