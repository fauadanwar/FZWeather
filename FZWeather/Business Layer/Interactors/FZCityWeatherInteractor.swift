//
//  FZCityWeatherInteractor.swift
//  FZWeather
//
//  Created by Fauad Anwar on 13/10/22.
//

import SwiftUI
import CoreLocation
import Combine

public enum FZWeatherError: Error {
    case error(_ errorString: String)
}

protocol FZCityWeatherInteractorProtocol: FZWeatherBaseDataHandlerProtocol {
    func getWeatherForUserLocation(completion: @escaping (Result<FZCityWeather, FZWeatherError>) -> Void)
    func getWeather(location: String, completion: @escaping (Result<FZCityWeather, FZWeatherError>) -> Void)
}

class FZCityWeatherInteractor: FZCityWeatherInteractorProtocol {
    
    var deviceLocationService = FZDeviceLocationService.shared
    var tokens: Set<AnyCancellable> = []
    
    func getWeatherForUserLocation(completion: @escaping (Result<FZCityWeather, FZWeatherError>) -> Void) {
        observeCoordinateUpdates(completion: completion)
        observeDeniedLocationAccess(completion: completion)
        deviceLocationService.requestLocation()
    }
    
    func observeCoordinateUpdates(completion: @escaping (Result<FZCityWeather, FZWeatherError>) -> Void) {
        deviceLocationService.coordinatesPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.deviceLocationService.stopLcoationUpdate()
            } receiveValue: { [weak self] location in
                self?.deviceLocationService.stopLcoationUpdate()
                CLGeocoder().reverseGeocodeLocation(location) { (placemarks, error) in
                    if error == nil {
                        if let firstLocation = placemarks?[0],
                           let cityName = firstLocation.locality { // get the city name
                            self?.callWeatherAPI(location: cityName, coordinates: location.coordinate, completion: completion)
                        }
                        else
                        {
                            completion(.failure(.error(NSLocalizedString("Unable to get City from device location", comment: ""))))
                        }
                    }
                    else
                    {
                        completion(.failure(.error(error!.localizedDescription)))
                    }
                }
            }
            .store(in: &tokens)
    }
    
    func observeDeniedLocationAccess(completion: @escaping (Result<FZCityWeather, FZWeatherError>) -> Void) {
        deviceLocationService.deniedLocationAccessPublisher
            .receive(on: DispatchQueue.main)
            .sink { authorizationStatus in
                
                switch authorizationStatus
                {
                case .restricted, .denied:
                    completion(.failure(.error(NSLocalizedString("Location access denied", comment: ""))))
                default:
                    print("waiting for location access")
                }
            }
            .store(in: &tokens)
    }
    
    func callWeatherAPI(location: String, coordinates: CLLocationCoordinate2D, completion: @escaping (Result<FZCityWeather, FZWeatherError>) -> Void) {
        let lat = coordinates.latitude
        let lon = coordinates.longitude
        let apiService = FZWebServiceUtility.shared
        let weaklyForcastComponents = FZRequestComponentsFromLatAndLon(lat: lat, lon: lon)
        apiService.getJSON(components: weaklyForcastComponents.urlComponentsFromLatAndLon) { (result: Result<FZWeather, FZWebServiceUtility.FZAPIError>) in
            switch result {
            case .success(let weather):
                if let cityWeather = weather.convertToFZCityWeather(location: location) {
                    completion(.success(cityWeather))
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
    }
    
    func getWeather(location: String, completion: @escaping (Result<FZCityWeather, FZWeatherError>) -> Void)
    {
        let geocoderUtility = FZGeocoderUtility()
        geocoderUtility.getCoordinates(location: location) {[weak self] result in
            switch result {
            case .success(let coordinates):
                self?.callWeatherAPI(location: location, coordinates: coordinates, completion: completion)
            case .failure(let geocoderError):
                switch geocoderError {
                case .error(let errorString):
                    completion(.failure(.error(errorString)))
                }
            }
        }
    }
}
