//
//  WeatherListViewController.swift
//  WeatherExpo
//
//  Created by Bitmad on 20/2/21.
//

import Foundation
import UIKit

final class WeatherListViewController: UIViewController {
    
    @IBOutlet var alphabetOrderButton: UIButton!
    @IBOutlet var temperatureOrderButton: UIButton!
    @IBOutlet var lastUpdatedOrderButton: UIButton!
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onAlphabetOrderButtonTapped(_ sender: Any) {
    }
    @IBAction func onTemperatureOrderButtonTapped(_ sender: Any) {
    }
    @IBAction func onLastUpdatedOrderButtonTapped(_ sender: Any) {
    }
    
    
}


