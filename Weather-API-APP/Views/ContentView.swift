//
//  ContentView.swift
//  Weather-API-APP
//
//  Created by Fadhli Firdaus on 09/03/2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    let weatherModel = WeatherModel()
    
    var body: some View {
        Text("hi")
            .onAppear {
                self.weatherModel.getWeatherData()
            }
    }
}

#Preview {
    ContentView()
}
