//
//  WeatherListResponse.swift
//  WeatherExpo
//
//  Created by Bitmad on 20/2/21.
//

import Foundation

struct WeatherListResponse: Decodable {
    let ret: Bool
    let isOkay: Bool
    let data: [Weather]
}
