    //
    //  BookmarkManager.swift
    //  Weather-API-APP
    //
    //  Created by Fadhli Firdaus on 10/03/2024.
    //

import Foundation

class BookmarkManager:ObservableObject {
    
    static let shared = BookmarkManager()
    private let userDefaultsKey = "BookmarkManagerData"
    
    private init() {
        loadFromUserDefaults()
    }
    
    @Published var datasource: [BookmarkedLocation] = [] {
        didSet {
            saveToUserDefaults()
        }
    }
    
    var previousLocation =  BookmarkedLocation(countryCode: "FR", cityName: "Paris", lat: 48.8566, long: 2.3522)
    
    var activeBookmark:BookmarkedLocation?
    
    func addBookmark(location:BookmarkedLocation){
        if(!datasource.contains(where: {$0 == location})){
            datasource.append(location)
        }
    }
    
    func checkIfExist(cityName:String) -> Bool{
        return datasource.contains { $0.cityName == cityName }
    }
    
    func removeIfExist(cityName:String){
        datasource.removeAll { $0.cityName == cityName }
    }
    private func saveToUserDefaults() {
        do {
            let encodedData = try JSONEncoder().encode(datasource)
            UserDefaults.standard.set(encodedData, forKey: userDefaultsKey)
            
            let previousLocationData = try JSONEncoder().encode(previousLocation)
            UserDefaults.standard.set(previousLocationData, forKey: "PreviousLocation")
        } catch {
            print("Error encoding data: \(error.localizedDescription)")
        }
    }
    
    private func loadFromUserDefaults() {
        if let encodedData = UserDefaults.standard.data(forKey: userDefaultsKey) {
            do {
                datasource = try JSONDecoder().decode([BookmarkedLocation].self, from: encodedData)
            } catch {
                print("Error decoding data: \(error.localizedDescription)")
            }
        }
        
        if let previousLocationData = UserDefaults.standard.data(forKey: "PreviousLocation") {
            do {
                previousLocation = try JSONDecoder().decode(BookmarkedLocation.self, from: previousLocationData)
            } catch {
                print("Error decoding previous location data: \(error.localizedDescription)")
            }
        }
    }
}

struct BookmarkedLocation:Hashable, Codable {
    let countryCode:String
    let cityName:String
    let lat:Double
    let long:Double
}
