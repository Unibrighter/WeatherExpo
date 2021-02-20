//
//  WeatherListPresenter.swift
//  WeatherExpo
//
//  Created by Bitmad on 20/2/21.
//

import Foundation

protocol WeatherListDisplaying: AnyObject {
    func set(items: [WeatherListCellItem])
    func set(filterCountries: [FilterCountryItem])
    func show(currentIndicator filterOption: FilterOption)
    func navigate(to item: WeatherListCellItem)
}

enum OrderOption {
    case alphabet
    case temperature
    case lastUpdated
    
    var buttonText: String {
        switch self {
        case .alphabet:
            return "A-Z"
        case .temperature:
            return "Temperature"
        case .lastUpdated:
            return "Last Updated"
        }
    }
}

enum FilterOption {
    case country(Country)
    case noFilter
}

final class WeatherListPresenter: NSObject {
    
    // MARK: Property
    
    private weak var display: WeatherListDisplaying!
    private weak var weatherListAPIManager: WeatherListAPIManager!
    
    private var cachedItems: [WeatherListCellItem] = []
    var order: OrderOption = .alphabet {
        didSet {
            retrieveWeatherList { (items) in
                display.set(items: items.applyFilter(option: filter).applyOrder(option: order))
            }
        }
    }
    var filter: FilterOption = .noFilter {
        didSet {
            retrieveWeatherList { (items) in
                display.set(items: items.applyFilter(option: filter).applyOrder(option: order))
            }
        }
    }
    
    // MARK: LifeCycle
    
    init(display: WeatherListDisplaying,
         weatherListAPIManager: WeatherListAPIManager = .shared) {
        self.display = display
        self.weatherListAPIManager = weatherListAPIManager
    }
    
    func displayDidLoad() {
        retrieveWeatherList(forceRefresh: true) { [weak self] (items) in
            self?.display.set(items: items)
            
            let countries = getCountryList(from: items)
            self?.display.set(filterCountries: countries.map { buildFilterCountryItem(from: $0) })
        }
    }
}

private extension WeatherListPresenter {

    func buildFilterCountryItem(from country: Country) -> FilterCountryItem {
        return FilterCountryItem(country: country) { [weak self] selectedCountry in
            guard let self = self else { return }
            self.filter = .country(selectedCountry)
            self.display.show(currentIndicator: self.filter)
        }
    }
    
    func retrieveWeatherList(forceRefresh: Bool = false, completion: ([WeatherListCellItem]) -> Void) {
        guard forceRefresh else {
            return completion(cachedItems)
        }
        
        weatherListAPIManager.getWeatherList { [weak self] (result) in
            switch result {
            case .success(let response):
                let items: [WeatherListCellItem] = response.data.compactMap {
                    guard var item = WeatherListCellItem(from: $0) else { return nil }
                    item.action = {
                        self?.display.navigate(to: item)
                    }
                    return item
                }
                self?.cachedItems = items
                completion(items)
            default:
                NSLog("Error occured...")
            }
        }
    }
    
    func getCountryList(from items: [WeatherListCellItem]) -> [Country] {
        let countries: [Country] = items.map {
            return $0.country
        }
        let unique = Array(Set(countries))
        return unique
    }
}

private extension Array where Element == WeatherListCellItem {
    func applyFilter(option: FilterOption) -> [WeatherListCellItem] {
        switch option {
        case .country(let country):
            return filter {
                return $0.country.countryID == country.countryID
            }
        default:
            return self
        }
    }
    
    func applyOrder(option: OrderOption) -> [WeatherListCellItem] {
        switch option {
        case .alphabet:
            return sorted {
                $0.venue < $1.venue
            }
        case .temperature:
            return sorted {
                $0.temperatureValue < $1.temperatureValue
            }
        case .lastUpdated:
            return sorted {
                $0.date < $1.date
            }
        }
    }
    
}
