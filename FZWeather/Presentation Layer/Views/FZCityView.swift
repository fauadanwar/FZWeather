//
//  FZCityView.swift
//  FZWeather
//
//  Created by Fauad Anwar on 16/10/22.
//

import SwiftUI
import MapKit

struct FZCityView: View {
    var presenter: FZCityPresenter
    @State var region: MKCoordinateRegion
    
    init(presenter: FZCityPresenter) {
        self.presenter = presenter
        self.region = presenter.region
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5){
            HStack {
                Text("Area:")
                Spacer()
                Text(presenter.area)
            }
            HStack {
                Text("Country:")
                Spacer()
                Text(presenter.country)
            }
            HStack {
                Text("Latitude:")
                Spacer()
                Text("\(presenter.coord.latitude)")
            }
            HStack {
                Text("Longitude:")
                Spacer()
                Text("\(presenter.coord.longitude)")
            }
            
            Map(coordinateRegion: $region, annotationItems: presenter.locations) { location in
                MapMarker(coordinate: location.coordinates)
            }
        }
        .navigationBarTitle(presenter.name, displayMode: .inline)
        .padding()
        Spacer()
    }
}

struct FZCityView_Previews: PreviewProvider {
    static var previews: some View {
        let city = FZCity.cityModels()
        FZCityView(presenter: FZCityPresenter(city: city, name: "Mumbai"))
    }
}
