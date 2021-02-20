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
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
