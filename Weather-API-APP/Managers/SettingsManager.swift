//
//  SettingsManager.swift
//  Weather-API-APP
//
//  Created by Fadhli Firdaus on 09/03/2024.
//

import Foundation
import Combine
import Foundation
import Combine

class SettingsManager: ObservableObject {
    
    static let shared = SettingsManager()
        
    @Published var unitMode: Unit = .metric {
        didSet {
            saveSettings()
        }
    }
    
    @Published var userLat = 51.509865 {
        didSet{
            saveSettings()
        }
    }
    @Published var userLong = -0.118092{
        didSet{
            saveSettings()
        }
    }
    @Published var userLang: Language = .English{
        didSet{
            saveSettings()
        }
    }
    
    private init() {
        loadSettings()
    }
    
    private let unitModeKey = "unitMode"
    private let userLatKey = "userLat"
    private let userLongKey = "userLong"
    private let userLangKey = "userLang"
    
    private func saveSettings() {
        let defaults = UserDefaults.standard
        defaults.set(unitMode.rawValue, forKey: unitModeKey)
        defaults.set(userLat, forKey: userLatKey)
        defaults.set(userLong, forKey: userLongKey)
        defaults.set(userLang.rawValue, forKey: userLangKey)
    }
    
    private func loadSettings() {
        let defaults = UserDefaults.standard
        if let unitModeValue = defaults.string(forKey: unitModeKey),
           let unit = Unit(rawValue: unitModeValue) {
            unitMode = unit
        }
        
        if let lat = defaults.value(forKey: userLatKey) as? Double {
            userLat = lat
        }
        
        if let long = defaults.value(forKey: userLongKey) as? Double {
            userLong = long
        }
        
        if let langValue = defaults.string(forKey: userLangKey),
           let lang = Language(rawValue: langValue) {
            userLang = lang
        }
    }
}


