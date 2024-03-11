//
//  BookmarkItem.swift
//  Weather-API-APP
//
//  Created by Fadhli Firdaus on 11/03/2024.
//

import SwiftUI

struct BookmarkItemView: View {
    var rw:CGFloat
    var rh:CGFloat
    
    @Binding var isWiggling:Bool
    @Binding var animation:Animation?
    @Binding var rotationEffect:Angle?
    @State var city:BookmarkedLocation
    var body: some View {
        VStack(spacing:0){
            Group{
                Circle()
                    .frame(width: rw/2, height: rw/2, alignment: .center)
                    .overlay {
                        Text("\(city.countryCode)")
                            .foregroundStyle(.white)
                    }
                    .overlay(content: {
                        if(isWiggling){
                            VStack(spacing:0){
                                HStack(spacing:0){
                                    Spacer()
                                    Image(systemName: "x.circle.fill")
                                        .resizable()
                                        .frame(width: rw/6, height: rw/6, alignment: .topLeading)
                                        .background(Circle()
                                            .foregroundColor(.white))
                                        .foregroundStyle(.red)
                                }
                                Spacer()
                            }
                            .frame(width: rw/2, height: rw/2, alignment: .center)
                            .zIndex(1)
                        }
                    })
                Spacer().frame(height: 10)
                Text("\(city.cityName)")
            }
        }
        .frame(width: rw, height: rh, alignment: .center)
    }
}
