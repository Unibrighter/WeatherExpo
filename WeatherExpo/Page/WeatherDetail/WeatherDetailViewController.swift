//
//  WeatherDetailViewController.swift
//  WeatherExpo
//
//  Created by Bitmad on 20/2/21.
//

import Foundation
import UIKit

final class WeatherDetailViewController: UIViewController {
    
    @IBOutlet var venueLabel: UILabel!
    @IBOutlet var weatherConditionLabel: UILabel!
    @IBOutlet var weatherTemperatureLabel: UILabel!
    
    @IBOutlet var feelsLikeHintLabel: UILabel!
    @IBOutlet var feelsLikeTemperatureLabel: UILabel!
    
    @IBOutlet var humidityHintLabel: UILabel!
    @IBOutlet var humidityLabel: UILabel!
    
    @IBOutlet var windHintLabel: UILabel!
    @IBOutlet var windLabel: UILabel!
    
    @IBOutlet var lastUpdatedDateLabel: UILabel!
    
    var detailItem: WeatherListCellItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configAppearance()
        config(with: detailItem)
    }
    
    func config(with item: WeatherListCellItem?) {
        guard let item = item else { return }
        
        venueLabel.text = item.venue
        weatherConditionLabel.text = item.weather
        weatherTemperatureLabel.text = item.temperature
        
        feelsLikeTemperatureLabel.text = item.feelsLikeTemperature
        humidityLabel.text = item.humidity
        windLabel.text = item.wind
        
        lastUpdatedDateLabel.text = item.lastUpdatedText
    }
    
    func configAppearance() {
        navigationItem.title = "Weather Detail"
        
        venueLabel.textColor = .gray
        weatherConditionLabel.textColor = .gray
        weatherTemperatureLabel.textColor = .accentLightBlue
            
        feelsLikeHintLabel.textColor = .gray
        feelsLikeTemperatureLabel.textColor = .accentLightBlue
            
        humidityHintLabel.textColor = .gray
        humidityLabel.textColor = .accentLightBlue
            
        windHintLabel.textColor = .gray
        windLabel.textColor = .accentLightBlue
    }
}
