//
//  WeatherDate.swift
//  WeatherExpo
//
//  Created by Bitmad on 20/2/21.
//

import Foundation

struct WeatherDate: Decodable {
    let date: Date
    
    init(from decoder: Decoder) throws {
        let timeInterval = try decoder.singleValueContainer().decode(Double.self)
        self.date = Date(timeIntervalSince1970: timeInterval)
    }
}
