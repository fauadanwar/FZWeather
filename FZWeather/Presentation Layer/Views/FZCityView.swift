//
//  FZCityView.swift
//  FZWeather
//
//  Created by Fauad Anwar on 16/10/22.
//

import SwiftUI
import MapKit

struct FZCityView: View {
    var viewModel: FZCityViewModel
    @State var region: MKCoordinateRegion
    
    init(viewModel: FZCityViewModel) {
        self.viewModel = viewModel
        self.region = viewModel.region
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5){
            HStack {
                Text("Area:")
                Spacer()
                Text(viewModel.area)
            }
            HStack {
                Text("Country:")
                Spacer()
                Text(viewModel.country)
            }
            HStack {
                Text("Latitude:")
                Spacer()
                Text("\(viewModel.coord.latitude)")
            }
            HStack {
                Text("Longitude:")
                Spacer()
                Text("\(viewModel.coord.longitude)")
            }
            
            Map(coordinateRegion: $region, annotationItems: viewModel.locations) { location in
                MapMarker(coordinate: location.coordinates)
            }
        }
        .navigationBarTitle(viewModel.name, displayMode: .inline)
        .padding()
        Spacer()
    }
}

struct FZCityView_Previews: PreviewProvider {
    static var previews: some View {
        let city = FZCity.cityModels()
        FZCityView(viewModel: FZCityViewModel(city: city, name: "Mumbai"))
    }
}
