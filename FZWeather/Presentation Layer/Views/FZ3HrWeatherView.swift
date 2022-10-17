//
//  FZ3HrWeatherView.swift
//  FZWeather
//
//  Created by Fauad Anwar on 16/10/22.
//

import SwiftUI

struct FZ3HrWeatherView: View {
    var viewModel: FZ3HrWeatherViewModel
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .center) {
                FZLazyImageView(lazyImageViewModel: viewModel.lazyImageViewModel)
                VStack(alignment: .leading, spacing: 5) {
                    HStack {
                        Text("Time:")
                            .font(.headline)
                        Spacer()
                        Text(viewModel.time)
                            .fontWeight(.bold)
                    }
                    HStack {
                        Text("Forecast:")
                            .font(.headline)
                        Spacer()
                        Text(viewModel.overview)
                            .fontWeight(.bold)
                    }
                    HStack {
                        Text(viewModel.temperature)
                        Spacer()
                        Text(viewModel.wind)
                    }
                    HStack {
                        Text(viewModel.clouds)
                        Spacer()
                        Text(viewModel.pop)
                    }
                }
            }
            HStack {
                Text(viewModel.humidity)
                if let rain = viewModel.rain
                {
                    Spacer()
                    Text(rain)
                }
                if let snow = viewModel.snow
                {
                    Spacer()
                    Text(snow)
                }
            }
        }
        .padding()
    }
}

struct FZ3HrWeatherView_Previews: PreviewProvider {
    static var previews: some View {
        FZ3HrWeatherView(viewModel: FZ3HrWeatherViewModel(system: 0, hourWeather: FZList.listModels().first!))
    }
}
