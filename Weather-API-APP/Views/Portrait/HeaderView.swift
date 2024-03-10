//
//  HeaderView.swift
//  Weather-API-APP
//
//  Created by Fadhli Firdaus on 10/03/2024.
//

import SwiftUI


struct HeaderView: View {
    @Binding var showHelp:Bool
    var body: some View {
        ZStack {
            Text("Pin to Peek")
                .font(.title)
                .onAppear {
                    
                }
            HStack {
                Spacer()
                Button {
                    showHelp = true
                } label: {
                    Image(systemName: "info.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30, alignment: .center)
                }
            }
            .padding([.trailing, .top], 8)
            .padding(.trailing, 7)
        }
    }
}
