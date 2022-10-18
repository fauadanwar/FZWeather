//
//  FZDeviceLocationService.swift
//  FZWeather
//
//  Created by Fauad Anwar on 18/10/22.
//

import Foundation
import CoreLocation

import Combine
import CoreLocation

class FZDeviceLocationService: NSObject, CLLocationManagerDelegate, ObservableObject {

    var coordinatesPublisher = PassthroughSubject<CLLocation, Error>()
    var deniedLocationAccessPublisher = PassthroughSubject<Void, Never>()

    private override init() {
        super.init()
    }
    static let shared = FZDeviceLocationService()

    private lazy var locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.delegate = self
        return manager
    }()

    
    func stopLcoationUpdate()
    {
        locationManager.stopUpdatingLocation()
    }
    
    func requestLocationUpdates() {
        switch locationManager.authorizationStatus {
            
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.startUpdatingLocation()
            
        default:
            deniedLocationAccessPublisher.send()
        }
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
            
        case .authorizedWhenInUse, .authorizedAlways:
            manager.startUpdatingLocation()
            
        default:
            manager.stopUpdatingLocation()
            deniedLocationAccessPublisher.send()
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations)
        guard let location = locations.last else { return }
        coordinatesPublisher.send(location)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        coordinatesPublisher.send(completion: .failure(error))
    }
}

