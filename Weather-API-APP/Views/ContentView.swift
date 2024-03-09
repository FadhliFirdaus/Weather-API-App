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
    let bookmarkManager = BookmarkManager()
    @State var screenManager:Screen = .Home
    @State var bookmarkSheet = false
    
    
    var body: some View {
        GeometryReader { reader in
            switch screenManager {
            case .Home:
                VStack(spacing:0){
                    ZStack {
                        Text("Pin to Peek")
                            .font(.title)
                            .onAppear {
                                self.weatherModel.getWeatherData()
                            }
                        HStack {
                            Spacer()
                            Button {
                                d("open info")
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
                                d("He")
                            } label: {
                                
                                HStack {
                                    Spacer()
                                    Text("Check again?")
                                    Spacer()
                                }
                            }

                        } header: {
                            Text("Last Location : \(bookmarkManager.previousLocation.cityName)")
                        }
                    }
                    .listRowBackground(Color.gray.opacity(0.1))
                    
                }
                .frame(width: w, height: h, alignment: .top)
                .sheet(isPresented: $bookmarkSheet, content: {
                    Text("hi")
                })
                
                
                
            case .MapPicker:
                Text("hi")
            case .BookmarkedLocations:
                Text("hi")
            }
            
        }
    }
}

#Preview {
    ContentView()
}
