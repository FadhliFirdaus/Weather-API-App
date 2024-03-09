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
    @StateObject var bookmarkManager = BookmarkManager()
    @ObservedObject var settingsManager = SettingsManager.shared
    @StateObject var weatherModel = WeatherModel.shared
    let locationManager = LocationManager()
    @State var bookmarkSheet = false
    @Binding var screen:Screen

    var body: some View {
        VStack(spacing:0){
            ZStack {
                Text("Pin to Peek")
                    .font(.title)
                    .onAppear {
//                        self.weatherModel.getWeatherData()
                    }
                HStack {
                    Spacer()
                    Button {
                    } label: {
                        Image(systemName: "info.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30, alignment: .center)
                    }
                    Spacer()
                        .frame(width: 15)
                }
                .padding(6)
            }
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
            Spacer()
                .frame(height: 15)
            Text("Click the picture to pin a point on the map!")
                .font(.caption)
            Spacer()
                .frame(height: 30)
            
            HStack {
                Spacer().frame(width: 15)
                Text("Bookmarked Locations")
                    .font(.subheadline)
                Spacer()
            }
            .padding(.bottom, 10)
            if(!bookmarkManager.datasource.isEmpty){
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
                                print("lat : \(settingsManager.userLat), long :\(settingsManager.userLong)")
                                settingsManager.userLat = city.lat
                                settingsManager.userLong = city.long 
                                print("lat : \(settingsManager.userLat), long :\(settingsManager.userLong)")
                                weatherModel.getWeatherData()
                                screen = .LocationDetailView
                            }
                        }
                        Spacer()
                    }
                }
                .background(Color.gray.opacity(0.1))
                .frame(width: w, height: w/4)
            }
            List{
                @State var previousLocation = bookmarkManager.previousLocation
                Section {
                    Text("Country Code : \(previousLocation.countryCode)")
                    Text("Latitude :  \(previousLocation.lat)")
                    Text("Longitude :  \(previousLocation.long)")
                    Button {
                        
                    } label : {
                        Text("Click to check again")
                    }
                    .buttonStyle(BorderlessButtonStyle())
                    Button {
                        
                    } label : {
                        Text("Click to check current location")
                    }
                    .buttonStyle(BorderlessButtonStyle())
                    
                } header: {
                    Text("Last Location : \(bookmarkManager.previousLocation.cityName)")
                }
            }
            .listRowBackground(Color.gray.opacity(0.1))
            
        }
        .frame(width: w, height: h, alignment: .top)
        .background(Color.gray.opacity(0.1))
        .sheet(isPresented: $bookmarkSheet, content: {
            Text("hi")
        })
    }
    
}

#Preview {
    HomeView(screen: .constant(.Home))
}
