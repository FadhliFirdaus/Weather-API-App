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
    @StateObject var bookmarkManager = BookmarkManager.shared
    
    

    var body: some View {

        if let weather = weather {
            ScrollView(.vertical){
                VStack(spacing:0){
                    TopView(screenManager: $screenManager, weather: weather)
                    DetailListView(weather: weather)
                }
                .frame(width: w, height: h, alignment: .top)
            }
            .frame(width: w, height: h, alignment: .top)
            .ignoresSafeArea()
            .onAppear {
                bookmarkManager.previousLocation = BookmarkedLocation(countryCode: weather.sys?.country ?? "", cityName: weather.name ?? "", lat: weather.coord?.lat ?? 0.0, long: weather.coord?.lon ?? 0.0)
            }
        } else {
            ScrollView(.vertical){
                LoadingView(screenManager: $screenManager, weather: $weather)
            }
            .frame(width: w, height: h, alignment: .top)
            .ignoresSafeArea()
        }
    }
}
