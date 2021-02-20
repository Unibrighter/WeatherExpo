//
//  Country.swift
//  WeatherExpo
//
//  Created by Bitmad on 20/2/21.
//

import Foundation

struct Country: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case countryID = "_countryID"
        case name = "_name"
    }
    
    let countryID: String
    let name: String
    
}
