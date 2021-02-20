//
//  WeatherListAPIManager.swift
//  WeatherExpo
//
//  Created by Bitmad on 20/2/21.
//

import Foundation

enum WEAPIError: Error {
    case networkError(Error)
    case requestError
    case dataError(Error)
}

typealias WeatherListResponseCompletionBlock = (Result<WeatherListResponse, WEAPIError>) -> Void

final class WeatherListAPIManager {
    
    // MARK: Property
    
    static let shared = WeatherListAPIManager()
    static let url: URL! = URL(string: "http://dnu5embx6omws.cloudfront.net/venues/weather.json")
    
    // MARK: APIs
    
    func getWeatherList(completion: @escaping WeatherListResponseCompletionBlock) {
        
        let task = URLSession.shared.dataTask(with: WeatherListAPIManager.url) {(data, _, error) in
            guard error == nil else {
                completion(Result.failure(WEAPIError.networkError(error!)))
                return
            }

            guard let data = data else {
                completion(Result.failure(WEAPIError.requestError))
                return
            }
            
            do {
                let response: WeatherListResponse = try JSONDecoder().decode(WeatherListResponse.self, from: data)
                completion(.success(response))
            } catch let error {
                return completion(.failure(WEAPIError.dataError(error)))
            }
        }
        task.resume()
    }
}
