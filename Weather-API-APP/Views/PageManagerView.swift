    //
    //  ContentView.swift
    //  Weather-API-APP
    //
    //  Created by Fadhli Firdaus on 09/03/2024.
    //

import SwiftUI
import SwiftData

struct ContentView: View {
    @StateObject var weatherModel = WeatherModel.shared
    @State var screenManager:Screen = .Home
    
    
    var body: some View {
        GeometryReader { reader in
            switch screenManager {
            case .Home:
                HomeView(screen: $screenManager)
            case .MapPicker:
                MapPinPicker(screen: $screenManager)
            case .BookmarkedLocations:
                Text("hi")
            case .LocationDetailView:
                DetailView(screenManager: $screenManager)
            case .SettingsView:
                SettingsView(screen: $screenManager)
            }
            
        }
    }
}

#Preview {
    ContentView()
}
