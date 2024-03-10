    //
    //  HomeView.swift
    //  Weather-API-APP
    //
    //  Created by Fadhli Firdaus on 10/03/2024.
    //

import SwiftUI
import CoreLocation
import CoreLocationUI

struct HomeView: View {
    @StateObject var bookmarkManager = BookmarkManager.shared
    @ObservedObject var settingsManager = SettingsManager.shared
    @StateObject var weatherModel = WeatherModel.shared
    @ObservedObject var locationManager = LocationManager()
    @State var bookmarkSheet = false
    @Binding var screen:Screen
    @State var showHelp = false
    
    var body: some View {
        
        @State var previousLocation = bookmarkManager.previousLocation
        
        VStack(spacing:0){
            HeaderView(showHelp: $showHelp)
            Spacer()
                .frame(height: 20)
            Button(action: {
                
            }, label: {
                Image("map")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: w - 30, alignment: .center)
                    .shadow(color: .black, radius: 5, x: 0, y: 0)
            })
            .padding(.bottom, 15)
            
            Text("Click the picture to pin a point on the map!")
                .font(.caption)
                .padding(.bottom, 30)
            
            HStack {
                Spacer().frame(width: 15)
                Text("Bookmarked Locations")
                    .font(.subheadline)
                Spacer()
            }
            .padding(.bottom, 10)
            if(!bookmarkManager.datasource.isEmpty){
                BookmarkListView(screen: $screen)
            }
            LastLocationView(screen: $screen)
        }
        .frame(width: w, height: h, alignment: .top)
        .background(Color.gray.opacity(0.1))
        .sheet(isPresented: $bookmarkSheet, content: {
            Text("hi")
        })
        .sheet(isPresented: $showHelp, content: {
            WebView(url: URL(string: "https://github.com/FadhliFirdaus/Weather-API-App/blob/master/README.md"))
        })
    }
    
}

#Preview {
    HomeView(screen: .constant(.Home))
}

