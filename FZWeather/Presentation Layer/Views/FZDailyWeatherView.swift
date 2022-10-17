//
//  FZDailyWeatherView.swift
//  FZWeather
//
//  Created by Fauad Anwar on 16/10/22.
//

import SwiftUI

struct FZDailyWeatherView: View {
    var viewModel: FZDailyWeatherViewModel
    var rowHeight: CGFloat = 40

    var body: some View {
        ZStack() {
                Rectangle()
                    .foregroundColor(.blue)
            HStack(alignment: .top, spacing: 0){
                Text(viewModel.day)
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
        let viewModel = FZDailyWeatherViewModel(daysWeather: FZDaysWeather.daysWeatherModels().first!, system: 0)
        FZDailyWeatherView(viewModel: viewModel)
    }
}
