//
//  LoadingView.swift
//  Weather-API-APP
//
//  Created by Fadhli Firdaus on 10/03/2024.
//

import SwiftUI

struct LoadingView: View {
    
    @Binding var screenManager:Screen
    @StateObject var weatherModel = WeatherModel.shared
    @Binding var weather:WeatherResponse?
    
    var body: some View {
        VStack(spacing:0){
            HStack(spacing:0){
                Button(action: {
                    withAnimation(.spring(.smooth(duration: 0.45))){
                        screenManager = .Home
                    }
                }, label: {
                    Image(systemName: "xmark.circle.fill")
                        .resizable()
                        .frame(width: 40, height: 40, alignment: .center)
                        .foregroundColor(.black)
                    Spacer()
                })
                .padding(.top, 15)
            }
            .padding(15)
            .offset(y: UIScreen.topSafeArea/2)
            .frame(width: w, height: h/10, alignment: .center)
            Spacer()
            ProgressView("Loading", value: 0.5, total: 1.0)
                .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                .animation(.easeInOut(duration: 1.0))
            Spacer()
        }
        .frame(width: w, height: h, alignment: .top)
        .onAppear(perform: {
            weatherModel.getWeatherData()
            var timer:Timer?
            timer = Timer.scheduledTimer(withTimeInterval: 1.5, repeats: true) { _ in
                withAnimation(.spring(.smooth(duration: 1.0))){
                    weather = weatherModel.activeWeatherData ?? nil
                }
                timer?.invalidate()
                timer = nil
            }
        })
    }
}

#Preview {
    LoadingView(screenManager: .constant(.Home), weather: .constant(mockWeatherResponse))
}
