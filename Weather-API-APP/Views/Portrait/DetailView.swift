    //
    //  BookmarkView.swift
    //  Weather-API-APP
    //
    //  Created by Fadhli Firdaus on 10/03/2024.
    //

import SwiftUI

struct DetailView: View {
    @State var weather:WeatherResponse?
    @Binding var screenManager:Screen
    @StateObject var settings = SettingsManager.shared
    @ObservedObject var weatherModel = WeatherModel.shared
    var body: some View {
        if let weather = weather {
            ScrollView(.vertical){
                VStack(spacing:0){
                    VStack{
                        HStack(spacing:0){
                            Button(action: {
                                screenManager = .Home
                                weatherModel.activeWeatherData = nil
                            }, label: {
                                Image(systemName: "arrowshape.backward.circle.fill")
                                    .resizable()
                                    .frame(width: 40, height: 40, alignment: .center)
                                    .foregroundColor(.black)
                                Spacer()
                            })
                            .padding(.top, 15)
                        }
                        .padding(15)
                        .offset(y: UIScreen.topSafeArea/2)
                        
                        .frame(width: w, height: h/10, alignment: .center)
                        Circle()
                            .frame(width: w/4 , height: w/4, alignment: .center)
                            .overlay {
                                Text("\(weather.sys?.country ?? "")")
                                    .foregroundStyle(.white)
                                    .font(.system(size: 44))
                                
                            }
                            .padding(.bottom, 30)
                    }
                    .background(Color.gray.opacity(0.11))
                    
                    List{
                        Section {
                            Text("\(weather.name ?? "") - \(weather.sys?.country ?? "") ")
                        } header: {
                            Text("City")
                        }
                        let symbol = self.settings.unitMode.getSymbol()
                        Section {
                            HStack {
                                Text("Forecasted :")
                                Spacer()
                                Text("\(weather.main?.temp?.decimalPlaces(2) ?? "") \(symbol)")
                            }
                            
                            HStack {
                                Text("Lowest :")
                                Spacer()
                                Text("\(weather.main?.temp_min?.decimalPlaces(2) ?? "") \(symbol)")
                            }
                            
                            HStack {
                                Text("Highest :")
                                Spacer()
                                Text("\(weather.main?.temp_max?.decimalPlaces(2) ?? "") \(symbol)")
                            }
                        } header: {
                            Text("Temperature")
                        }
                        
                        Section {
                            HStack {
                                Text("Air Pressure :")
                                Spacer()
                                Text("\(String(weather.main?.pressure ?? 0)) hPa")
                            }
                            
                            
                            HStack {
                                Text("Humidity :")
                                Spacer()
                                Text("\(weather.main?.humidity ?? 0) %")
                            }
                            
                            
                            HStack {
                                Text("Sea level pressure :")
                                Spacer()
                                Text("\(String(weather.main?.sea_level ?? 0)) hPa")
                            }
                            
                            
                            
                            HStack {
                                Text("Ground level pressure :")
                                Spacer()
                                Text("\(String(weather.main?.grnd_level ?? 0)) hPa")
                            }
                        } header: {
                            Text("Atmospheric Details")
                        }
                        
                        Section {
                            Text("\(String(weather.visibility ?? 0)) metres")
                        } header: {
                            Text("Visibility")
                        }
                        
                        let rate = settings.unitMode.getMS()
                        if let wind = weather.wind {
                            Section {
                                if let speed = weather.wind?.speed {
                                    PairedRowText(left: "Speed",
                                                  right: "\(speed) \(rate)")
                                }
                                if let deg = wind.deg {
                                    PairedRowText(left: "Direction", right: "\(String(weather.wind?.deg ?? 0))° Degree")
                                }
                                if let gust = wind.gust {
                                    PairedRowText(left: "Gust", right: "\(String(weather.wind?.gust ?? 0)) \(rate)")
                                }
                            } header: {
                                Text("Wind")
                            }
                        }
                        
                        Section {
                            PairedRowText(left: "Cloudiness", right: "\(String(weather.clouds?.all ?? 0)) %")
                        } header: {
                            Text("Clouds")
                        }
                        
                        if let rain = weather.rain, let rain11 = rain.h1, let rain33 = rain.h3 {
                            Section {
                                if let rain1  = rain.h1 {
                                    PairedRowText(left: "Last hour", right: "\(String(rain1)) mm")
                                }
                                if let rain3 = rain.h3 {
                                    PairedRowText(left: "Last 3 hours", right: "\(String(rain3)) mm")
                                }
                            } header: {
                                Text("Rain")
                            }
                        }
                        
                        if let snow = weather.snow {
                            if let snow1 = snow.h1 {
                                PairedRowText(left: "Last hour", right: "\(String(snow1)) mm")
                            }
                            if let snow3 = snow.h3 {
                                PairedRowText(left: "Last 3 hours", right: "\(String(snow3)) mm")
                            }
                            
                        }
                        
                        
                    }
                    .listSectionSpacing(0)
                }
                .frame(width: w, height: h, alignment: .top)
            }
            .frame(width: w, height: h, alignment: .top)
            .ignoresSafeArea()
        } else {
            VStack{
                HStack(spacing:0){
                    Button(action: {
                        screenManager = .Home
                    }, label: {
                        Image(systemName: "arrowshape.backward.circle.fill")
                            .resizable()
                            .frame(width: 40, height: 40, alignment: .center)
                            .foregroundColor(.black)
                        Spacer()
                    })
                }
                .padding(15)
                Spacer()
                ProgressView("Loading", value: 0.5, total: 1.0)
                    .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                    .animation(.easeInOut(duration: 1.0))
                    .padding(.bottom, 40)
                Spacer()
            }
            .frame(width: w, height: h, alignment: .center)
            .onAppear(perform: {
                weatherModel.getWeatherData()
                Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
                    weather = weatherModel.activeWeatherData
                }
            })
            
        }
    }
}

