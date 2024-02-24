//
//  FZDailyWeatherView.swift
//  FZWeather
//
//  Created by Fauad Anwar on 16/10/22.
//

import SwiftUI

struct FZDailyWeatherView: View {
    var presenter: FZDailyWeatherPresenter
    var rowHeight: CGFloat = 40

    var body: some View {
        ZStack() {
                Rectangle()
                    .foregroundColor(.blue)
            HStack(alignment: .top, spacing: 0){
                Text(presenter.day)
                    .lineLimit(1)
                    .padding(10)
                    .foregroundColor(.white)
                    .font(.title2)
                    .bold()
                Spacer()
            }
        }//ZStack
        .frame(height: rowHeight)
    }
}

struct FZDailyWeatherView_Previews: PreviewProvider {
    static var previews: some View {
        let presenter = FZDailyWeatherPresenter(daysWeather: FZDaysWeather.daysWeatherModels().first!, temperatureEnum: .celsius)
        FZDailyWeatherView(presenter: presenter)
    }
}
