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
    
    func getWeatherList(completion: @escaping WeatherListResponseCompletionBlock) {
        let url = URL(string: "http://dnu5embx6omws.cloudfront.net/venues/weather.json")!

        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data, error == nil else { return completion(.failure(error!)) }
            do {
                let response: WeatherListResponse = try JSONDecoder().decode(WeatherListResponse.self, from: data)
                completion(.success(response))
            } catch let error {
                return completion(.failure(error))
            }
        }
        task.resume()
    }
}
