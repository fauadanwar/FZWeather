//
//  FZWebServiceUtility.swift
//  FZWeather
//
//  Created by Fauad Anwar on 16/10/22.
//

import Combine
import Foundation

extension Encodable
{
    func convertToURLQueryItems() -> [URLQueryItem]?
    {
        do {
            let encoder = try JSONEncoder().encode(self)
            let requestDictionary = (try? JSONSerialization.jsonObject(with: encoder, options: .allowFragments)).flatMap{$0 as? [String: Any?]}

            if(requestDictionary != nil)
            {
                var queryItems: [URLQueryItem] = []

                requestDictionary?.forEach({ (key, value) in

                    if let value
                    {
                        if let strValue = value as? String, strValue.count != 0 {
                            queryItems.append(URLQueryItem(name: key, value: strValue))
                        }
                        else if let doubleValue = value as? Double {
                            let strValue = String(format: "%f", doubleValue)
                            queryItems.append(URLQueryItem(name: key, value: strValue))
                        }
                    }
                })

                return queryItems
            }


        } catch let error {
            debugPrint(error)
        }

        return nil
    }
}

public class FZWebServiceUtility {
    public static let shared = FZWebServiceUtility()
    var cancellables = Set<AnyCancellable>()
    public enum FZAPIError: Error {
        case error(_ errorString: String)
    }
    
    public func getJSON<RequestQueryItems: Encodable, Response: Decodable>(urlString: String,
                                                                           requestQueryItems: RequestQueryItems?,
                                      dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .secondsSince1970,
                                      keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys,
                                      completion: @escaping (Result<Response, FZAPIError>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(.error(NSLocalizedString("Error: Invalid URL", comment: ""))))
            return
        }
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        components?.queryItems = requestQueryItems?.convertToURLQueryItems()
        
        guard let requestURL = components?.url else {
            completion(.failure(.error(NSLocalizedString("Error: Invalid URL", comment: ""))))
            return
        }
        let request = URLRequest(url: requestURL)
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = dateDecodingStrategy
        decoder.keyDecodingStrategy = keyDecodingStrategy
        URLSession.shared.dataTaskPublisher(for: request)
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

