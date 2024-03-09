//
//  Enums.swift
//  Weather-API-APP
//
//  Created by Fadhli Firdaus on 09/03/2024.
//

import Foundation

/*
 Units of measurement. standard, metric and imperial units are available. If you do not use the units parameter, standard units will be applied by default.
 Learn more
 */

enum Unit:String {
    case standard = "Kelvin"
    case metric = "Celsius"
    case imperial = "Fahrenheit"
}
/*
 main.temp Temperature. Unit Default: Kelvin, Metric: Celsius, Imperial: Fahrenheit
 */
