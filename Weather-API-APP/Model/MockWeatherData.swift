//
//  NewModel.swift
//  Weather-API-APP
//
//  Created by Fadhli Firdaus on 10/03/2024.
//

import Foundation

let mockWeatherResponse: WeatherResponse = WeatherResponse(
    coord: Coordinate(lat: -50, lon: 120.0),
    weather: [Weather(main: "Sunny", description: "Clear sky")],
    main: Details(
        temp: 25.0,
        feels_like: 24.0,
        temp_min: 23.0,
        temp_max: 28.0,
        pressure: 1010,
        humidity: 60,
        sea_level: 1012,
        grnd_level: 1008
    ),
    visibility: 10000,
    wind: Wind(speed: 5.0, deg: 180, gust: 7.0),
    clouds: Cloud(all: 20),
    rain: Rain(h1: 0.5, h3: 1.0),
    snow: Snow(h1: 0.2, h3: 0.5),
    sys: SystemData(country: "US", sunrise: 1615329514, sunset: 1615373214),
    timezone: 3600,
    name: "MockCity"
)
