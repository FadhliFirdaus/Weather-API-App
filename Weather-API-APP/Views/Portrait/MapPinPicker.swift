    //
    //  MapPinPicker.swift
    //  Weather-API-APP
    //
    //  Created by Fadhli Firdaus on 11/03/2024.
    //

import SwiftUI
import MapKit

struct MapPinPicker: View {
    @State private var placeName: String = ""
    @State private var coordinates: CLLocationCoordinate2D?
    @Binding var screen:Screen
    @StateObject var wm = WeatherModel.shared
    @StateObject var sm = SettingsManager.shared
    @State private var position = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 3.1466, longitude: 101.6958),
            span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
        )
    )
    @State var searchPosition:MKCoordinateRegion?

    
    var body: some View {
        VStack {
            TextField("Enter place name", text: $placeName, onCommit: {
            })
            .padding()
            .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Map(position: $position, interactionModes: .all)
                .mapStyle(.hybrid(elevation: .realistic))
                .overlay {
                    Image(systemName: "pin.circle")
                        .resizable()
                        .frame(width: 20, height: 20, alignment: .center)
                        .padding(.bottom, 11)
                        .foregroundColor(.red)
                        .scaledToFit()
                        .shadow(color: .white, radius: 1)
                }
                .onMapCameraChange { context in
                    sm.userLat = context.region.center.latitude
                    sm.userLong = context.region.center.longitude
                    d("lat = \(sm.userLat), long = \(sm.userLong)")
                }

            Button(action: {
                wm.getWeatherData()
                screen = .LocationDetailView
                
            }, label: {
                Text("Peek this location!")
            })
            .padding(12)
        }
    }
}

#Preview {
    MapPinPicker(screen: .constant(.MapPicker))
}
