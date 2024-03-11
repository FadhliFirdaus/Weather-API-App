//
//  SettingsView.swift
//  Weather-API-APP
//
//  Created by Fadhli Firdaus on 11/03/2024.
//

import SwiftUI

struct SettingsView: View {
    @StateObject var sm = SettingsManager.shared
    @State var metric: Unit = .standard
    @State var language: Language = .English
    @Binding var screen:Screen
    
    var body: some View {
        VStack {
            Text("Settings")
                .font(.title)
                .padding(12)
            
            List {
                Section(header: Text("Metric")) {
                    Picker("Unit Selection", selection: $metric) {
                        ForEach(Unit.allCases) { unit in
                            Text("\(unit.getName())")
                        }
                    }
                    .pickerStyle(.segmented)
                }
                .onAppear(perform: {
                    
                    metric = sm.unitMode
                    language = sm.userLang
                })
                
                Section(header: Text("Language")) {
                    Picker("Language", selection: $language) {
                        ForEach(Language.allCases) { lang in
                            Text("\(lang.rawValue)")
                        }
                    }
                    .pickerStyle(.segmented)
                }
            }
            .frame(height: 200)
            .listRowBackground(Color.clear)
            
            Button(action: {
                sm.unitMode = metric
                sm.userLang = language
                screen = .Home
            }, label: {
                Text("Save")
            })
            .buttonStyle(.borderedProminent)
        }
        .frame(height:h, alignment: .top)
        .onAppear(perform: {
        })
    }
}

#Preview {
    SettingsView(screen: .constant(.SettingsView))
}
