//
//  FZCityPresenter.swift
//  FZWeather
//
//  Created by Fauad Anwar on 17/10/22.
//

import Foundation
import CoreLocation
import MapKit

struct FZCityPresenter
{
    var city: FZCity
    var name: String
    
    var region: MKCoordinateRegion
    {
        return MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: city.coord.lat, longitude: city.coord.lon), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
    }
    
    var area: String {
        return city.name
    }

    var coord: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: city.coord.lat, longitude: city.coord.lon)
    }
    
    var country: String {
        return city.country
    }
    
    var locations: [FZMapAnnotationLocation]
    {
        return [FZMapAnnotationLocation(name: name, coordinates: CLLocationCoordinate2D(latitude: city.coord.lat, longitude: city.coord.lon))]
    }
}
