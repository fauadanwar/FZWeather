//
//  FZCityWeatherView.swift
//  Weather
//
//  Created by Fauad Anwar on 12/10/22.
//

import SwiftUI

struct FZCityWeatherView: View {
    @StateObject var presenter = FZCityWeatherPresenter()
    
    var body: some View {
        ZStack {
            NavigationView {
                VStack {
                    HStack {
                        TextField("Enter Location", text: $presenter.location,
                                  onCommit: {
                            presenter.getWeather()
                        })
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .overlay (
                            Button(action: {
                                presenter.location = ""
                                presenter.getWeather()
                            }) {
                                Image(systemName: "xmark.circle")
                                    .foregroundColor(.gray)
                            }
                                .padding(.horizontal),
                            alignment: .trailing
                        )
                        Button {
                            presenter.getWeather()
                        } label: {
                            Image(systemName: "magnifyingglass.circle.fill")
                                .font(.title3)
                        }
                    }
                    .padding(.horizontal)
                    List {
                        if let cityPresenter = presenter.cityPresenter
                        {
                            NavigationLink(destination: FZCityView(presenter: cityPresenter)) {
                                HStack {
                                    Text("City:")
                                    Spacer()
                                    Text(cityPresenter.name)
                                }
                            }
                        }
                        ForEach(presenter.dailyWeatherPresenter, id: \.day) { dailyWeatherPresenter in
                            Section(header: Text(dailyWeatherPresenter.day)) {
                                ForEach(dailyWeatherPresenter.hourlyWeatherPresenter, id: \.time) {
                                    hourlyWeatherPresenter in
                                    FZ3HrWeatherView(presenter: hourlyWeatherPresenter)
                                }
                            }
                        }
                    }
                    .refreshable {
                        presenter.getWeather()
                    }
                    .listStyle(InsetListStyle())
                }
                .navigationBarTitle("Weather", displayMode: .inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Picker(selection: $presenter.temperatureEnum, label: Text("Reading Type")) {
                            Text(TemperatureEnum.celsius.localizedName).tag(TemperatureEnum.celsius)
                            Text(TemperatureEnum.fahrenheit.localizedName).tag(TemperatureEnum.fahrenheit)
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .frame(width: 100)
                    }
                }
                .alert(item: $presenter.appError) { appAlert in
                    Alert(title: Text("Error"),
                          message: Text("""
                            \(appAlert.errorString)
                            Please try again later!
                            """
                                       )
                    )
                }
            }
            .navigationViewStyle(StackNavigationViewStyle())
            if presenter.isLoading {
                ZStack {
                    Color(.white)
                        .opacity(0.3)
                        .ignoresSafeArea()
                    ProgressView("Fetching Weather")
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color(.systemBackground))
                        )
                        .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/ )
                }
            }
        }
    }
}

struct FZCityWeatherView_Previews: PreviewProvider {
    static var previews: some View {
        FZCityWeatherView()
            .environment(\.locale, .init(identifier: "en"))
    }
}
