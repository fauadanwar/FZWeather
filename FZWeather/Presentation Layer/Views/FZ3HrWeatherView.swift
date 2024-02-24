//
//  FZ3HrWeatherView.swift
//  FZWeather
//
//  Created by Fauad Anwar on 16/10/22.
//

import SwiftUI

struct FZ3HrWeatherView: View {
    var presenter: FZ3HrWeatherPresenter
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .center) {
                FZLazyImageView(lazyImagePresenter: presenter.lazyImagePresenter)
                VStack(alignment: .leading, spacing: 5) {
                    HStack {
                        Text("Time:")
                            .font(.headline)
                        Spacer()
                        Text(presenter.time)
                            .fontWeight(.bold)
                    }
                    HStack {
                        Text("Forecast:")
                            .font(.headline)
                        Spacer()
                        Text(presenter.overview)
                            .fontWeight(.bold)
                    }
                    HStack {
                        Text(presenter.temperature)
                        Spacer()
                        Text(presenter.wind)
                    }
                    HStack {
                        Text(presenter.clouds)
                        Spacer()
                        Text(presenter.pop)
                    }
                }
            }
            HStack {
                Text(presenter.humidity)
                if let rain = presenter.rain
                {
                    Spacer()
                    Text(rain)
                }
                if let snow = presenter.snow
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
        FZ3HrWeatherView(presenter: FZ3HrWeatherPresenter(temperatureEnum: .celsius, hourWeather: FZList.listModels().first!))
    }
}
