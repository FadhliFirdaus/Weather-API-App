//
//  DetailListView.swift
//  Weather-API-APP
//
//  Created by Fadhli Firdaus on 10/03/2024.
//

import Foundation
import SwiftUI

struct DetailListView:View {
    @State var weather:WeatherResponse
    @StateObject var settings = SettingsManager.shared
    var body: some View{
        List{
            Section {
                Text("\(weather.name ?? "") - \(weather.sys?.country ?? "") ")
                
            } header: {
                Text("City")
            }
            
            Section {
                PairedRowText(left: "Latitude : ", right: "\(String(weather.coord?.lat ?? 0.0))°")
                PairedRowText(left: "Longitude : ", right: "\(String(weather.coord?.lon ?? 0.0))°")
            } header: {
                Text("Coordinate")
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
            
            let rate = settings.unitMode.getMS(lang: settings.userLang)
            if let wind = weather.wind {
                Section {
                    if let speed = weather.wind?.speed {
                        PairedRowText(left: "Speed",
                                      right: "\(speed) \(rate)")
                    }
                    if wind.deg != nil {
                        PairedRowText(left: "Direction", right: "\(String(weather.wind?.deg ?? 0))°")
                    }
                    if wind.gust != nil {
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
            
            if let rain = weather.rain, let _ = rain.h1, let _ = rain.h3 {
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
}
