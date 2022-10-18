//
//  FZLazyImageInteractor.swift
//  FZWeather
//
//  Created by Fauad Anwar on 18/10/22.
//

import Foundation
import UIKit

protocol FZLazyImageInteractorProtocol {
    
    func getImage(imagePath: URL, completion: @escaping (Result<UIImage, Error>) -> Void)
}

class FZLazyImageInteractor: FZLazyImageInteractorProtocol {
    
    func getImage(imagePath: URL, completion: @escaping (Result<UIImage, Error>) -> Void)
    {
        FZImageCachingUtility.shared.getImage(imagePath: imagePath) { (result: Result<UIImage, Error>) in
            switch result{
            case .success(let image):
                completion(.success(image))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
