//
//  KeychainUtility.swift
//  FZWeather
//
//  Created by Fanwar on 29/02/24.
//

import Foundation

class KeychainUtility<T: Codable> {

    private let service = "com.FZWeather.localPublicKey"

    func save(value: T, forKey key: String) {
        do {
            let data = try JSONEncoder().encode(value)
            let query: [String: Any] = [
                kSecClass as String: kSecClassGenericPassword,
                kSecAttrService as String: service,
                kSecAttrAccount as String: key,
                kSecValueData as String: data
            ]

            // Delete existing entry before saving to avoid duplicates
            SecItemDelete(query as CFDictionary)

            // Save the new entry
            let status = SecItemAdd(query as CFDictionary, nil)
            guard status == errSecSuccess else {
                print("Error saving data to Keychain: \(status)")
                return
            }
        } catch {
            print("Error encoding data: \(error)")
        }
    }

    func retrieve(forKey key: String) -> T? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: key,
            kSecReturnData as String: kCFBooleanTrue as NSNumber,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]

        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)

        if status == errSecSuccess {
            if let data = result as? Data {
                do {
                    return try JSONDecoder().decode(T.self, from: data)
                } catch {
                    print("Error decoding data: \(error)")
                }
            }
        } else if status == errSecItemNotFound {
            // Data not found in Keychain
            return nil
        } else {
            print("Error reading data from Keychain: \(status)")
        }

        return nil
    }
}
