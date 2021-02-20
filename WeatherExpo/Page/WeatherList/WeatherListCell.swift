//
//  WeatherListCell.swift
//  WeatherExpo
//
//  Created by Bitmad on 20/2/21.
//

import UIKit

final class WeatherListCell: UITableViewCell {
    
    @IBOutlet var venueNameLabel: UILabel!
    @IBOutlet var weatherConditionLabel: UILabel!
    @IBOutlet var weatherTemperatureLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        weatherTemperatureLabel.textColor = .accentLightBlue
        venueNameLabel.textColor = .gray
        weatherConditionLabel.textColor = .gray
    }

    func config(with item: WeatherListCellItem) {
        venueNameLabel.text = item.venue
        weatherConditionLabel.text = item.weather
        weatherTemperatureLabel.text = item.temperature
    }
}
