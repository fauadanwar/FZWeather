//
//  FZWebServiceUtility.swift
//  FZWeather
//
//  Created by Fauad Anwar on 16/10/22.
//

import Combine
import CommonCrypto
import Security
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

public class FZWebServiceUtility: NSObject {
    
    public static let shared = FZWebServiceUtility()
    
    private var session: URLSession!
        
    private override init() {
        super.init()
        session = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
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

extension FZWebServiceUtility: URLSessionDelegate {

    // URLSessionDelegate method for handling authentication challenges
    public func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {

        // Store the local public key securely (e.g., in Keychain)
        let localPublicKey: String? = SecureStorage.getLocalPublicKey()
        
        // Create a server trust
        guard let serverTrust = challenge.protectionSpace.serverTrust,
              let certificateChain = SecTrustCopyCertificateChain(serverTrust) as? [SecCertificate],
              let certificate = certificateChain.first,
              let serverPublicKey = SecCertificateCopyKey(certificate),
              let serverPublicKeyData = SecKeyCopyExternalRepresentation(serverPublicKey, nil),
              let localPublicKey = localPublicKey else {
            completionHandler(.cancelAuthenticationChallenge, nil)
            return
        }

        let data: Data = serverPublicKeyData as Data
        let serverHashKey = data.sha256()

        // Compare server and local hash keys
        if serverHashKey == localPublicKey {
            let credential: URLCredential = URLCredential(trust: serverTrust)
            print("Public Key pinning is successful")
            completionHandler(.useCredential, credential)
        } else {
            print("Public Key pinning is failed")
            completionHandler(.cancelAuthenticationChallenge, nil)
        }
    }
}

// Example implementation of sha256 hashing
extension Data {
    func sha256() -> String {
        let rsa2048Asn1Header: [UInt8] = [
            0x30, 0x82, 0x01, 0x22, 0x30, 0x0d, 0x06, 0x09, 0x2a, 0x86, 0x48, 0x86,
            0xf7, 0x0d, 0x01, 0x01, 0x01, 0x05, 0x00, 0x03, 0x82, 0x01, 0x0f, 0x00
        ]

        var keyWithHeader = Data(rsa2048Asn1Header)
        keyWithHeader.append(self)
        var hash = [UInt8](repeating: 0, count: Int(CC_SHA256_DIGEST_LENGTH))

        keyWithHeader.withUnsafeBytes {
            _ = CC_SHA256($0.baseAddress, CC_LONG(keyWithHeader.count), &hash)
        }
        return Data(hash).base64EncodedString()
    }
}

// Secure storage example (you need to implement this)
class SecureStorage {
    static func getLocalPublicKey() -> String? {
        // Example usage with String
        let keychainString = KeychainUtility<String>()
        if let retrievedString = keychainString.retrieve(forKey: "PublicKey") {
            return retrievedString
        }
        return nil
    }
}
