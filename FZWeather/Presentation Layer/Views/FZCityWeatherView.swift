//
//  FZCityWeatherView.swift
//  Weather
//
//  Created by Fauad Anwar on 12/10/22.
//

import SwiftUI

struct FZCityWeatherView: View {
    @StateObject var viewModel = FZCityWeatherViewModel()
    
    var body: some View {
        ZStack {
            NavigationView {
                VStack {
                    HStack {
                        TextField("Enter Location", text: $viewModel.location,
                                  onCommit: {
                            viewModel.getWeather()
                        })
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .overlay (
                            Button(action: {
                                viewModel.location = ""
                                viewModel.getWeather()
                            }) {
                                Image(systemName: "xmark.circle")
                                    .foregroundColor(.gray)
                            }
                                .padding(.horizontal),
                            alignment: .trailing
                        )
                        Button {
                            viewModel.getWeather()
                        } label: {
                            Image(systemName: "magnifyingglass.circle.fill")
                                .font(.title3)
                        }
                    }
                    .padding(.horizontal)
                    List {
                        if let cityViewModel = viewModel.cityViewModel
                        {
                            NavigationLink(destination: FZCityView(viewModel: cityViewModel)) {
                                HStack {
                                    Text("City:")
                                    Spacer()
                                    Text(cityViewModel.name)
                                }
                            }
                        }
                        ForEach(viewModel.dailyWeatherViewModel, id: \.day) { dailyWeatherViewModel in
                            Section(header: Text(dailyWeatherViewModel.day)) {
                                ForEach(dailyWeatherViewModel.hourlyWeatherViewModel, id: \.time) {
                                    hourlyWeatherViewModel in
                                    FZ3HrWeatherView(viewModel: hourlyWeatherViewModel)
                                }
                            }
                        }
                    }
                    .refreshable {
                        viewModel.getWeather()
                    }
                    .listStyle(InsetListStyle())
                }
                .navigationBarTitle("Weather", displayMode: .inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Picker(selection: $viewModel.system, label: Text("Reading Type")) {
                            Text("°C").tag(0)
                            Text("°F").tag(1)
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .frame(width: 100)
                    }
                }
                .alert(item: $viewModel.appError) { appAlert in
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
            if viewModel.isLoading {
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
