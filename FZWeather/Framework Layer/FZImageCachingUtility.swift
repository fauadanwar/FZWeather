//
//  FZImageCachingUtility.swift
//  FZWeather
//
//  Created by Fauad Anwar on 18/10/22.
//

import Foundation
import UIKit

public class FZImageCachingUtility {
    public static let shared = FZImageCachingUtility()
    private let imageCache = NSCache<AnyObject, UIImage>()
    
    func getImage(imagePath: URL, completion: @escaping (Result<UIImage, Error>) -> Void)
    {
        if let cachedImage = self.imageCache.object(forKey: imagePath.path() as AnyObject)
        {
            completion(.success(cachedImage))
            return
        }
        
        var urlRequest = URLRequest(url: imagePath)
        urlRequest.httpMethod = "get"
        URLSession.shared.dataTask(with: urlRequest) { [weak self] imageData, response, error in
            if let imageData, error == nil {
                DispatchQueue.main.async {
                    if let image = UIImage(data: imageData) {
                        self?.imageCache.setObject(image, forKey: imagePath.path() as AnyObject)
                        completion(.success(image))
                    }
                }
            }
            else
            {
                completion(.failure(error!))
            }
        }.resume()
    }
}
