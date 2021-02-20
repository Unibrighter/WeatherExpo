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
            retrieveWeatherList { [weak self] (items) in
                guard let self = self else { return }
                self.display.set(items: items.applyFilter(option: self.filter).applyOrder(option: self.order))
            }
        }
    }
    var filter: FilterOption = .noFilter {
        didSet {
            retrieveWeatherList { [weak self] (items) in
                guard let self = self else { return }
                self.display.set(items: items.applyFilter(option: self.filter).applyOrder(option: self.order))
                self.display.show(currentIndicator: self.filter)
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
        refreshWeatherList()
    }
    
    func refreshWeatherList(completion: (() -> Void)? = nil) {
        retrieveWeatherList(forceRefresh: true) { [weak self] (items) in
            guard let self = self else { return }
            self.display.set(items: items)
            self.display.set(filterCountries: items.countryList.map { self.buildFilterCountryItem(from: $0) })
            completion?()
        }
    }
}

// MARK: Helper Functions

private extension WeatherListPresenter {
    
    func buildFilterCountryItem(from country: Country) -> FilterCountryItem {
        return FilterCountryItem(country: country) { [weak self] selectedCountry in
            guard let self = self else { return }
            self.filter = .country(selectedCountry)
            self.display.show(currentIndicator: self.filter)
        }
    }
    
    func retrieveWeatherList(forceRefresh: Bool = false, completion: @escaping ([WeatherListCellItem]) -> Void) {
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
            case .failure(let error):
                NSLog("Error occured: \(error.localizedDescription)")
            }
        }
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
            let itemsWithDate = filter { return $0.date != nil }
            
            return itemsWithDate.sorted {
                $0.date! < $1.date!
            }
        }
    }
    
    var countryList: [Country] {
        var result: [Country] = []
        result.append(contentsOf: Set(map {
            return $0.country
        }))
        return result.sorted { return $0.name < $1.name }
    }
    
}
