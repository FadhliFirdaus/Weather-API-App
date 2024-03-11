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
    @State var isWiggling = false
    @State var animation:Animation?
    @State var rotationEffect:Angle?
    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing:0){
                @State var bookmarkData = bookmarkManager.datasource
                ForEach(bookmarkData, id:\.self){city in
                    GeometryReader{ reader in
                        let rw = reader.size.width
                        let rh = reader.size.height
                        BookmarkItemView(rw: rw, rh: rh, isWiggling: $isWiggling, animation: $animation, rotationEffect: $rotationEffect, city: city)
                    }
                    .frame(width: w/4, height: w/4, alignment: .center)
                    .onTapGesture {
                        if(isWiggling){
                            bookmarkManager.removeIfExist(cityName: city.cityName)
                        } else {
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
                    .onLongPressGesture {
                        self.isWiggling.toggle()
                    }
                }
                Spacer()
            }
            .padding(.leading, 12)
        }
        .background(Color.gray.opacity(0.1))
        .frame(width: w, height: w/4)
        .scrollIndicators(.hidden)
    }
}
