//
//  BookmarkListView.swift
//  Weather-API-APP
//
//  Created by Fadhli Firdaus on 10/03/2024.
//

import SwiftUI

struct BookmarkListView: View {
    @StateObject var weatherModel = WeatherModel.shared
    @StateObject var bookmarkManager = BookmarkManager.shared
    @StateObject var settingsManager = SettingsManager.shared
    @Binding var screen:Screen
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing:0){
                ForEach(bookmarkManager.datasource, id:\.self){city in
                    GeometryReader{ reader in
                        let rw = reader.size.width
                        let rh = reader.size.height
                        VStack(spacing:0){
                            Circle()
                                .frame(width: rw/2, height: rw/2, alignment: .center)
                                .overlay {
                                    Text("\(city.countryCode)")
                                        .foregroundStyle(.white)
                                }
                            Spacer().frame(height: 10)
                            Text("\(city.cityName)")
                        }
                        .frame(width: rw, height: rh, alignment: .center)
                    }
                    .frame(width: w/4, height: w/4, alignment: .center)
                    .onTapGesture {
                        settingsManager.userLat = city.lat
                        settingsManager.userLong = city.long
                        weatherModel.getWeatherData()
                        var timer:Timer?
                        timer = Timer.scheduledTimer(withTimeInterval: 0.15, repeats: false) { _ in
                            withAnimation {
                                screen = .LocationDetailView
                            }
                            timer?.invalidate()
                            timer = nil
                        }
                    }
                }
                Spacer()
            }
        }
        .background(Color.gray.opacity(0.1))
        .frame(width: w, height: w/4)
        .scrollIndicators(.hidden)
    }
}
