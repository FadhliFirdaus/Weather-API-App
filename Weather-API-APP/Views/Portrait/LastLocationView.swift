//
//  LastLocationView.swift
//  Weather-API-APP
//
//  Created by Fadhli Firdaus on 10/03/2024.
//

import SwiftUI

struct LastLocationView: View {
    @StateObject var weatherModel = WeatherModel.shared
    @StateObject var bookmarkManager = BookmarkManager.shared
    @StateObject var settingsManager = SettingsManager.shared
    @Binding var screen:Screen
    var body: some View {
        @State var previousLocation = bookmarkManager.previousLocation
        List{
            Section {
                PairedRowText(left: "Country Code : ", right: previousLocation.countryCode)
                PairedRowText(left: "City :  ", right: previousLocation.cityName)
                PairedRowText(left: "Latitude", right: String(previousLocation.lat.decimalPlaces(4)))
                PairedRowText(left: "Longitude :  ", right: String(previousLocation.long.decimalPlaces(4)))
                
                Button {
                    var timer:Timer?
                    timer = Timer.scheduledTimer(withTimeInterval: 0.15, repeats: false) { _ in
                        withAnimation {
                            screen = .LocationDetailView
                        }
                        timer?.invalidate()
                        timer = nil
                    }
                    weatherModel.getWeatherData()
                } label : {
                    Text("Check again")
                }
                .buttonStyle(BorderlessButtonStyle())
                Button {
                    
                } label : {
                    Text("Check current location")
                }
                .buttonStyle(BorderlessButtonStyle())
                
            } header: {
                Text("Last Location")
            }
        }
        .listRowBackground(Color.gray.opacity(0.1))
        .padding(.bottom, 30)
    }
}
