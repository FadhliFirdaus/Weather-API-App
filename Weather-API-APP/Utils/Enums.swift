//
//  Enums.swift
//  Weather-API-APP
//
//  Created by Fadhli Firdaus on 09/03/2024.
//

import Foundation

enum Unit:String {
    case standard = "Kelvin"
    case metric = "Celsius"
    case imperial = "Fahrenheit"
}

enum Screen {
    case Home
    case MapPicker
    case BookmarkedLocations
}
