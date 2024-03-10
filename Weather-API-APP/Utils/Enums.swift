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
    
    func getSymbol() -> String {
        switch self {
        case .standard:
            return "K"
        case .metric:
            return "\u{00B0}C"
        case .imperial:
            return "\u{00B0}F"
        }
    }
    
    func getMS() -> String{
        switch self{
        case .standard:
            return "meter/sec"
        case .metric:
            return "meter/sec"
        case .imperial:
            return "miles/hour"
        }
    }
}

enum Screen {
    case Home
    case MapPicker
    case BookmarkedLocations
    case LocationDetailView
}
