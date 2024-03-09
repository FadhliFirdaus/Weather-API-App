//
//  SettingsManager.swift
//  Weather-API-APP
//
//  Created by Fadhli Firdaus on 09/03/2024.
//

import Foundation

class SettingsManager:ObservableObject {
    var unitMode:Unit = .standard
    var userLat = 5.5145
    var userLong = 102.5331
    var userLang = "en"
}
