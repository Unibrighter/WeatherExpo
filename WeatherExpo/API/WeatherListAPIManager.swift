//
//  WeatherListAPIManager.swift
//  WeatherExpo
//
//  Created by Bitmad on 20/2/21.
//

import Foundation

typealias WeatherListResponseCompletionBlock = (Result<WeatherListResponse, Error>) -> Void
typealias CountryNamesResponseCompletionBlock = (Result<[String], Error>) -> Void

final class WeatherListAPIManager {
    
    static let shared = WeatherListAPIManager()
    
    let stubJSON =
    """
    {
        "ret": true,
        "isOkay": true,
        "data": [
            {
                "_venueID": "97",
                "_name": "Adelaide River",
                "_country": {
                    "_countryID": "16",
                    "_name": "Australia"
                },
                "_weatherCondition": "Partly Cloudy",
                "_weatherConditionIcon": "partlycloudy",
                "_weatherWind": "Wind: ESE at 17kph",
                "_weatherHumidity": "Humidity: 65%",
                "_weatherTemp": "27",
                "_weatherFeelsLike": "34",
                "_sport": {
                    "_sportID": "1",
                    "_description": "Horse Racing"
                },
                "_weatherLastUpdated": 1401666605
            },
            {
                "_venueID": "105",
                "_name": "Albany",
                "_country": {
                    "_countryID": "16",
                    "_name": "Australia"
                },
                "_weatherConditionIcon": "clear",
                "_weatherWind": "Wind: West at 16kph",
                "_weatherHumidity": "Humidity: 91%",
                "_weatherTemp": "14",
                "_weatherFeelsLike": "14",
                "_sport": {
                    "_sportID": "1",
                    "_description": "Horse Racing"
                },
                "_weatherLastUpdated": 1399679406
            },
            {
                "_venueID": "69",
                "_name": "Albury",
                "_country": {
                    "_countryID": "16",
                    "_name": "Australia"
                },
                "_weatherCondition": "Clear",
                "_weatherConditionIcon": "clear",
                "_weatherWind": "Wind: North at 2.6kph",
                "_weatherHumidity": "Humidity: 83%",
                "_weatherTemp": "9",
                "_weatherFeelsLike": "9",
                "_sport": {
                    "_sportID": "1",
                    "_description": "Horse Racing"
                },
                "_weatherLastUpdated": 1408146604
            },
            {
                "_venueID": "38",
                "_name": "Alice Springs",
                "_country": {
                    "_countryID": "16",
                    "_name": "Australia"
                },
                "_weatherCondition": "Partly Cloudy",
                "_weatherConditionIcon": "partlycloudy",
                "_weatherWind": "Wind: East at 1.6kph",
                "_weatherHumidity": "Humidity: 33%",
                "_weatherTemp": "16",
                "_weatherFeelsLike": "16",
                "_sport": {
                    "_sportID": "1",
                    "_description": "Horse Racing"
                },
                "_weatherLastUpdated": 1408837808
            },
            {
                "_venueID": "127",
                "_name": "Armidale",
                "_country": {
                    "_countryID": "16",
                    "_name": "Australia"
                },
                "_weatherCondition": "Partly Cloudy",
                "_weatherConditionIcon": "partlycloudy",
                "_weatherWind": "Wind: ENE at 9kph",
                "_weatherHumidity": "Humidity: 91%",
                "_weatherTemp": "10",
                "_weatherFeelsLike": "10",
                "_sport": {
                    "_sportID": "1",
                    "_description": "Horse Racing"
                },
                "_weatherLastUpdated": 1408924202
            }
        ]
    }
    """
    
    func getWeatherList(completion: WeatherListResponseCompletionBlock) {
        guard let data = stubJSON.data(using: String.Encoding.utf8) else {
            completion(.failure(NSError()))
            return
        }
        do {
            let response: WeatherListResponse = try JSONDecoder().decode(WeatherListResponse.self, from: data)
            completion(.success(response))
        } catch (let error){
            completion(.failure(error))
            return
        }
    }
    
    func getCountryList(completion: CountryNamesResponseCompletionBlock) {
        guard let data = stubJSON.data(using: String.Encoding.utf8) else {
            completion(.failure(NSError()))
            return
        }
        do {
            let response: WeatherListResponse = try JSONDecoder().decode(WeatherListResponse.self, from: data)
            let countries = Array(Set(response.data.compactMap{ return $0.country.name }))
            completion(.success(countries))
        } catch (let error){
            completion(.failure(error))
            return
        }
    }
}
