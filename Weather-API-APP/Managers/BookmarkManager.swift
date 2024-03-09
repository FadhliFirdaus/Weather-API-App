//
//  BookmarkManager.swift
//  Weather-API-APP
//
//  Created by Fadhli Firdaus on 10/03/2024.
//

import Foundation

class BookmarkManager:ObservableObject {
    var datasource:[BookmarkedLocation] = [
        BookmarkedLocation(countryCode: "US", cityName: "New York", lat: 40.7128, long: -74.0060),
        BookmarkedLocation(countryCode: "UK", cityName: "London", lat: 51.5074, long: -0.1278),
        BookmarkedLocation(countryCode: "FR", cityName: "Paris", lat: 48.8566, long: 2.3522),
    ]
    
    var previousLocation =  BookmarkedLocation(countryCode: "FR", cityName: "Paris", lat: 48.8566, long: 2.3522)

}

struct BookmarkedLocation:Hashable {
    let countryCode:String
    let cityName:String
    let lat:Double
    let long:Double
}
