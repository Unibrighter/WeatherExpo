//
//  WeatherListCellItem.swift
//  WeatherExpo
//
//  Created by Bitmad on 20/2/21.
//

import Foundation
import UIKit

struct WeatherListCellItem {
    
    let country: Country
    let date: Date?
    
    let temperatureValue: Int
    
    let venue: String
    let weather: String
    let temperature: String
    let feelsLikeTemperature: String
    let humidity: String
    let wind: String
    var action: (() -> Void)?
}

extension WeatherListCellItem {
    
    private static var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.amSymbol = "AM"
        dateFormatter.pmSymbol = "PM"
        dateFormatter.dateFormat = "hh:mma dd MMMM yyyy"
        return dateFormatter
    }()
    
    var lastUpdatedText: String {
        guard let date = date else {
            return "Last updated: Unknown"
        }
        
        return "Last updated: \(WeatherListCellItem.dateFormatter.string(from: date))"
    }
    
    init?(from weather: Weather) {
        guard let weatherHumidity = weather.weatherHumidity,
              let weatherWind = weather.weatherWind,
              let weatherTemp = weather.weatherTemp,
              let weatherCondition = weather.weatherCondition,
              let weatherFeelsLike = weather.weatherFeelsLike else {
            return nil
        }
        
        let humidityText = weatherHumidity.replacingOccurrences(of: "Humidity: ", with: "")
        let windText = weatherWind.replacingOccurrences(of: "Wind: ", with: "")
        
        self.init(country: weather.country,
                  date: weather.weatherLastUpdated?.date,
                  temperatureValue: Int(weatherTemp) ?? 0,
                  venue: weather.name,
                  weather: weatherCondition,
                  temperature: "\(weatherTemp)°",
                  feelsLikeTemperature: "\(weatherFeelsLike)°",
                  humidity: humidityText,
                  wind: windText,
                  action: nil)
    }
}
