//
//  WeatherListPresenter.swift
//  WeatherExpo
//
//  Created by Bitmad on 20/2/21.
//

import Foundation

protocol WeatherListDisplaying: AnyObject {
    func set(items: [WeatherListCellItem])
}

final class WeatherListPresenter: NSObject {
    
    
    // MARK: Property
    private weak var display: WeatherListDisplaying!
    private weak var weatherListAPIManager: WeatherListAPIManager!
    
    init(display: WeatherListDisplaying,
         weatherListAPIManager: WeatherListAPIManager = .shared) {
        self.display = display
        self.weatherListAPIManager = weatherListAPIManager
    }
    
    func displayDidLoad() {
        retrieveWeatherList { [weak self] (items) in
            self?.display.set(items: items)
        }
    }
    
    func retrieveWeatherList(completion: ([WeatherListCellItem]) -> Void) {
        weatherListAPIManager.getWeatherList { (result) in
            switch result {
            case .success(let response):
                let items: [WeatherListCellItem] = response.data.compactMap {
                    WeatherListCellItem(from: $0)
                }
                completion(items)
            default:
                NSLog("Error occured...")
            }
        }
    }
}
