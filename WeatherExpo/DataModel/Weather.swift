//
//  Weather.swift
//  WeatherExpo
//
//  Created by Bitmad on 20/2/21.
//

import Foundation

struct Weather: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case venueID = "_venueID"
        case name = "_name"
        case country = "_country"
        case weatherCondition = "_weatherCondition"
        case weatherConditionIcon = "_weatherConditionIcon"
        case weatherWind = "_weatherWind"
        case weatherHumidity = "_weatherHumidity"
        case weatherTemp = "_weatherTemp"
        case weatherFeelsLike = "_weatherFeelsLike"
        case sport = "_sport"
        case weatherLastUpdated = "_weatherLastUpdated"
    }
    
    let venueID: String
    let name: String
    let country: Country
    let weatherCondition: String
    let weatherConditionIcon: String
    let weatherWind: String
    let weatherHumidity: String
    let weatherTemp: String
    let weatherFeelsLike: String
    let sport: Sport
    let weatherLastUpdated: WeatherDate
    
}
