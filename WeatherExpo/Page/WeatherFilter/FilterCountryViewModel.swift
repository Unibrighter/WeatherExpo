//
//  FilterCountryViewModel.swift
//  WeatherExpo
//
//  Created by Bitmad on 20/2/21.
//

import Foundation
import UIKit

struct FilterCountryItem {
    let country: Country
    var action: ((Country) -> Void)?
}
