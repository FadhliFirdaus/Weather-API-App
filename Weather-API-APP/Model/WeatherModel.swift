//
//  WeatherModel.swift
//  Weather-API-APP
//
//  Created by Fadhli Firdaus on 09/03/2024.
//

import Foundation


class WeatherModel {
    
    var weatherDatasource:WeatherResponse?
    
    func getWeatherURL(settingsData:SettingsManager) -> String {
        let latitude = "lat=\(settingsData.userLat)"
        let longitude = "&lon=\(settingsData.userLong)"
        let lang = "&lang=\(settingsData.userLang)"
        let units = "&units=\(settingsData.unitMode)"
        let apiKey = "&appid=\(APIManager.WeatherAPIKey)"
        return APIManager.WeatherAPIbaseURL + "?" + latitude + longitude + lang + units + apiKey
    }
    
    func getWeatherData() {
        let sett = SettingsManager()
        let weatherURL = getWeatherURL(settingsData: sett)
        
        guard let url = URL(string: weatherURL) else {
            d("Invalid URL")
            return
        }
        
        let urlSession = URLSession(configuration: .default).dataTask(with: url) { (data, response, error) in
            if error != nil {
                return
            }
            d(weatherURL)
            if let data = data {
                self.decodeWeatherResponse(data: data)
            }
        }
        urlSession.resume()
    }
    
    func decodeWeatherResponse(data:Data) {
        do {
            let decodedResponse = try JSONDecoder().decode(WeatherResponse.self, from: data)
            print("Decoded Weather Response: \(decodedResponse)")
            self.weatherDatasource = decodedResponse
        } catch {
            d("error decoding")
        }
    }

}

struct WeatherResponse: Decodable {
    let weather: [Weather]
    let main: Details
    let visibility: Int
    let wind: Wind
    let clouds: Cloud
    let rain: Rain?
    let snow: Snow?
    let sys: SystemData
    let timezone: Int
    let name: String
}

struct Weather: Decodable {
    let main: String
    let description: String
}

struct Details: Decodable {
    let temp: Double
    let feels_like: Double
    let temp_min: Double
    let temp_max: Double
    let pressure: Int
    let humidity: Int
    let sea_level: Int
    let grnd_level: Int
}

struct Wind: Decodable {
    let speed: Double
    let deg: Int
    let gust: Double
}

struct Cloud: Decodable {
    let all: Int
}

struct Rain: Decodable {
    let h1: Double?
    let h3: Double?
    
    enum CodingKeys: String, CodingKey {
        case h1 = "1h"
        case h3 = "3h"
    }
}

struct Snow: Decodable {
    let h1: Double?
    let h3: Double?
    
    enum CodingKeys: String, CodingKey {
        case h1 = "1h"
        case h3 = "3h"
    }
}

struct SystemData: Decodable {
    let country: String
    let sunrise: Int
    let sunset: Int
}

