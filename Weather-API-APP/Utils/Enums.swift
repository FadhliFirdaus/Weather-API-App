    //
    //  Enums.swift
    //  Weather-API-APP
    //
    //  Created by Fadhli Firdaus on 09/03/2024.
    //

import Foundation

enum Unit:String, CaseIterable, Identifiable, CustomStringConvertible {
    case standard = "standard"
    case metric = "metric"
    case imperial = "imperial"
    
    
    func getName() ->String {
        switch self {
        case .standard :
            return "Kelvin"
        case .metric:
            return "Celsius"
        case .imperial :
            return "Fahrenheit"
        }
    }
    var id: Self { self }
    
    var description: String {
        return self.rawValue
    }
    
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
    
    func getMS(lang:Language) -> String{
        switch lang {
        case .English:
            switch self{
            case .standard:
                return "meter/sec"
            case .metric:
                return "meter/sec"
            case .imperial:
                return "miles/hour"
            }
        case .Malay:
            switch self{
            case .standard:
                return "meter/saat"
            case .metric:
                return "meter/saat"
            case .imperial:
                return "batu/jam"
            }
        case .Arabic:
            switch self{
            case .standard:
                return "متر - ثانية"
            case .metric:
                return "متر - ثانية"
            case .imperial:
                return "ميل - ساعة"
            }
        }
        
    }
}
enum Language:String, CaseIterable, Identifiable, CustomStringConvertible {
    case English = "English"
    case Malay = "Malay"
    case Arabic = "Arabic"
    
    func getSymbol(lang:Language) -> String{
        switch self {
        case .Arabic:
            return "ar"
        case .English:
            return "en"
        case .Malay:
            return "my"
        }
    }
    
    
    var id: Self { self }
    
    var description: String {
        return self.rawValue
    }
}



enum Screen {
    case Home
    case MapPicker
    case BookmarkedLocations
    case LocationDetailView
    case SettingsView
}
