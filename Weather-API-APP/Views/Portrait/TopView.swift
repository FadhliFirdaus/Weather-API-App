//
//  TopView.swift
//  Weather-API-APP
//
//  Created by Fadhli Firdaus on 10/03/2024.
//

import Foundation
import SwiftUI

struct TopView:View {
    @Binding var screenManager:Screen
    @State var weather:WeatherResponse
    @ObservedObject var weatherModel = WeatherModel.shared
    @State var bookmarkState = false
    @StateObject var bookmarkManager = BookmarkManager.shared
    
    var body: some View {
        
        VStack(spacing:0){
            @State var imageName = bookmarkState ? "bookmark.circle.fill":"bookmark.circle"
            HStack(spacing:0){
                Button(action: {
                    weatherModel.activeWeatherData = nil
                    withAnimation(.spring(.smooth(duration: 0.45))){
                        screenManager = .Home
                    }
                }, label: {
                    Image(systemName: "arrowshape.backward.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40, alignment: .center)
                        .foregroundColor(.black)
                    Spacer()
                })
                .padding(.top, 15)
                Spacer()
                Button(action: {
                    withAnimation(.spring(.smooth(duration: 0.45))){
                        if(!bookmarkState){
                            bookmarkState.toggle()
                        }
                        let toAdd = BookmarkedLocation(countryCode: weather.sys?.country ?? "", cityName: weather.name ?? "", lat: weather.coord?.lat ?? -1, long: weather.coord?.lon ?? -1)
                        bookmarkManager.addBookmark(location: toAdd)
                    }
                }, label: {
                    Spacer()
                    Image(systemName: imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40, alignment: .center)
                        .foregroundColor(.black)
                })
                .padding(.top, 15)
            }
            .padding(15)
            .offset(y: UIScreen.topSafeArea/2)
            .frame(width: w, height: h/10, alignment: .center)
            
            
            Circle()
                .frame(width: w/4 , height: w/4, alignment: .center)
                .overlay {
                    Text("\(weather.sys?.country ?? "")")
                        .foregroundStyle(.white)
                        .font(.system(size: 44))
                    
                }
                .padding(.bottom, 30)
        }
        .background(Color.gray.opacity(0.11))
        .onAppear(perform: {
            bookmarkState = bookmarkManager.checkIfExist(cityName: weather.name ?? "")
        })
    }
}



