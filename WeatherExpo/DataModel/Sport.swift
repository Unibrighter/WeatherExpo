//
//  Sport.swift
//  WeatherExpo
//
//  Created by Bitmad on 20/2/21.
//

import Foundation

struct Sport: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case sportID = "_sportID"
        case description = "_description"
    }
    
    let sportID: String
    let description: String
}
