//
//  FZWebServiceUtility.swift
//  FZWeather
//
//  Created by Fauad Anwar on 16/10/22.
//

import Combine
import Foundation

//protocol WeatherFetchable {
//  func weeklyWeatherForecast(
//    forCity city: String
//  ) -> AnyPublisher<WeeklyForecastResponse, WeatherError>
//
//  func currentWeatherForecast(
//    forCity city: String
//  ) -> AnyPublisher<CurrentWeatherForecastResponse, WeatherError>
//}

public class FZWebServiceUtility {
    public static let shared = FZWebServiceUtility()
    private let session: URLSession
    init(session: URLSession = .shared) {
      self.session = session
    }
    var cancellables = Set<AnyCancellable>()
    public enum FZAPIError: Error {
        case error(_ errorString: String)
    }
    
    
    public func getJSON<Response: Decodable>(components: URLComponents,
                                      dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .secondsSince1970,
                                      keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys,
                                      completion: @escaping (Result<Response, FZAPIError>) -> Void) {
        guard let requestURL = components.url else {
            completion(.failure(.error(NSLocalizedString("Error: Invalid URL", comment: ""))))
            return
        }
        let request = URLRequest(url: requestURL)
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = dateDecodingStrategy
        decoder.keyDecodingStrategy = keyDecodingStrategy
        self.session.dataTaskPublisher(for: request)
            .map { $0.data }
            .decode(type: Response.self, decoder: decoder)
            .sink { (taskCompletion) in
                switch taskCompletion {
                case .finished:
                    return
                case .failure(let decodingError):
                    completion(.failure(FZAPIError.error("Error: \(decodingError.localizedDescription)")))
                }
                
            } receiveValue: { (decodedData) in
                completion(.success(decodedData))
            }
            .store(in: &cancellables)
    }
}

