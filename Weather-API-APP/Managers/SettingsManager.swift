//
//  SettingsManager.swift
//  Weather-API-APP
//
//  Created by Fadhli Firdaus on 09/03/2024.
//

import Foundation
import Combine

class SettingsManager: ObservableObject {
    
    static let shared = SettingsManager()
    
        // MARK: - Published Variables
    
    @Published var unitMode: Unit = .metric
    @Published var userLat = 51.509865
    @Published var userLong = -0.118092
    @Published var userLang = "en"
    
        // Private initializer to prevent external instantiation
    private init() {}
}

