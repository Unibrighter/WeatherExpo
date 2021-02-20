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

extension Country: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(countryID)
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.countryID == rhs.countryID
    }
}
