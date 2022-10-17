//
//  FZGeocoderUtility.swift
//  FZWeather
//
//  Created by Fauad Anwar on 16/10/22.
//

import CoreLocation

public class FZGeocoderUtility
{
    public enum GeocoderError: Error {
        case error(_ errorString: String)
    }
    
    public func getCoordinates(location: String, completion: @escaping (Result<CLLocationCoordinate2D, GeocoderError>) -> Void)
    {
        CLGeocoder().geocodeAddressString(location) { (placemarks, error) in
            if let error = error as? CLError {
                switch error.code {
                case .locationUnknown, .geocodeFoundNoResult, .geocodeFoundPartialResult:
                    completion(.failure(.error(NSLocalizedString("Unable to determine location from this text.", comment: ""))))
                case .network:
                    completion(.failure(.error(NSLocalizedString("You do not appear to have a network connection.", comment: ""))))
                default:
                    completion(.failure(GeocoderError.error("Error: \(error.localizedDescription)")))
                }
            }
            
            if let coordinate = placemarks?.first?.location?.coordinate
            {
                completion(.success(coordinate))
            }
            else
            {
                completion(.failure(.error(NSLocalizedString("Unable to determine location from this text.", comment: ""))))
            }
        }
    }
}

