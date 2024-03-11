    //
    //  WeatherModel.swift
    //  Weather-API-APP
    //
    //  Created by Fadhli Firdaus on 09/03/2024.
    //

import Foundation


class WeatherModel:ObservableObject {
    
    static let shared = WeatherModel()
    
    private init() {} 
    
    
    @Published var activeWeatherData:WeatherResponse?
    let sett = SettingsManager.shared
    
    func getWeatherURL(settingsData:SettingsManager) -> String {
        let latitude = "lat=\(settingsData.userLat)"
        let longitude = "&lon=\(settingsData.userLong)"
        let lang = "&lang=\(settingsData.userLang.getSymbol(lang: settingsData.userLang))"
        let units = "&units=\(settingsData.unitMode)"
        let apiKey = "&appid=\(APIManager.WeatherAPIKey)"
        return APIManager.WeatherAPIbaseURL + "?" + latitude + longitude + lang + units + apiKey
    }
    
    func getWeatherData() {
        let weatherURL = getWeatherURL(settingsData: sett)
        d(weatherURL)
        guard let url = URL(string: weatherURL) else {
            return
        }
        callURLSession(withURL: url)
    }
    
    func decodeWeatherResponse(data:Data) {
        do {
            let decodedResponse = try JSONDecoder().decode(WeatherResponse.self, from: data)
            DispatchQueue.main.async {
                self.activeWeatherData = decodedResponse
                d(decodedResponse)
            }
        } catch let error {
            print(error)
        }
    }
    
    func callURLSession(withURL: URL) {
//        print("url is : \(withURL)")

        let urlSession = URLSession(configuration: .default).dataTask(with: withURL) { (data, response, error) in

            if let error = error {
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {

                return
            }
            
            if let data = data {
                self.decodeWeatherResponse(data: data)
            }
        }
        urlSession.resume()
    }
}


struct WeatherResponse: Decodable {
    let coord:Coordinate?
    let weather: [Weather]?
    let main: Details?
    let visibility: Int?
    let wind: Wind?
    let clouds: Cloud?
    let rain: Rain?
    let snow: Snow?
    let sys: SystemData?
    let timezone: Int?
    let name: String?
    
    enum CodingKeys: String, CodingKey {
        case coord
        case weather
        case main
        case visibility
        case wind
        case clouds
        case rain
        case snow
        case sys
        case timezone
        case name
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.coord = try container.decodeIfPresent(Coordinate.self, forKey: .coord)
        self.weather = try container.decodeIfPresent([Weather].self, forKey: .weather)
        self.main = try container.decodeIfPresent(Details.self, forKey: .main)
        self.visibility = try container.decodeIfPresent(Int.self, forKey: .visibility)
        self.wind = try container.decodeIfPresent(Wind.self, forKey: .wind)
        self.clouds = try container.decodeIfPresent(Cloud.self, forKey: .clouds)
        self.rain = try container.decodeIfPresent(Rain.self, forKey: .rain)
        self.snow = try container.decodeIfPresent(Snow.self, forKey: .snow)
        self.sys = try container.decodeIfPresent(SystemData.self, forKey: .sys)
        self.timezone = try container.decodeIfPresent(Int.self, forKey: .timezone)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
    }
    
    init(coord:Coordinate?,
         weather: [Weather]?,
         main: Details?,
         visibility: Int?,
         wind: Wind?,
         clouds: Cloud?,
         rain: Rain?,
         snow: Snow?,
         sys: SystemData?,
         timezone: Int?,
         name: String?) {
        self.coord = coord
        self.weather = weather
        self.main = main
        self.visibility = visibility
        self.wind = wind
        self.clouds = clouds
        self.rain = rain
        self.snow = snow
        self.sys = sys
        self.timezone = timezone
        self.name = name
    }
}

struct Coordinate:Decodable {
    let lat:Double?
    let lon:Double?
    
    init(lat: Double?, lon: Double?) {
        self.lat = lat
        self.lon = lon
    }
}

struct Weather: Decodable {
    let main: String?
    let description: String?
    
    init(main: String?, description: String?) {
        self.main = main
        self.description = description
    }
}

struct Details: Decodable {
    let temp: Double?
    let feels_like: Double?
    let temp_min: Double?
    let temp_max: Double?
    let pressure: Int?
    let humidity: Int?
    var sea_level: Int?
    var grnd_level: Int?
    
    init(temp: Double?, feels_like: Double?, temp_min: Double?, temp_max: Double?, pressure: Int?, humidity: Int?, sea_level: Int?, grnd_level: Int?) {
        self.temp = temp
        self.feels_like = feels_like
        self.temp_min = temp_min
        self.temp_max = temp_max
        self.pressure = pressure
        self.humidity = humidity
        self.sea_level = sea_level
        self.grnd_level = grnd_level
    }
}

struct Wind: Decodable {
    let speed: Double?
    let deg: Int?
    let gust: Double?
    
    init(speed: Double?, deg: Int?, gust: Double?) {
        self.speed = speed
        self.deg = deg
        self.gust = gust
    }
}

struct Cloud: Decodable {
    let all: Int?
    
    init(all: Int?) {
        self.all = all
    }
}

struct Rain: Decodable {
    let h1: Double?
    let h3: Double?
    
    init(h1: Double?, h3: Double?) {
        self.h1 = h1
        self.h3 = h3
    }
}

struct Snow: Decodable {
    let h1: Double?
    let h3: Double?
    
    init(h1: Double?, h3: Double?) {
        self.h1 = h1
        self.h3 = h3
    }
}

struct SystemData: Decodable {
    let country: String?
    let sunrise: Int?
    let sunset: Int?
    
    init(country: String?, sunrise: Int?, sunset: Int?) {
        self.country = country
        self.sunrise = sunrise
        self.sunset = sunset
    }
}
