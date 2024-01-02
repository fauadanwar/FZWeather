//
//  FZLazyImagePresenter.swift
//  FZWeather
//
//  Created by Fauad Anwar on 17/10/22.
//

import Foundation
import UIKit

class FZLazyImagePresenter : ObservableObject {
    @Published var downloadedImage = UIImage(systemName: "hourglass.circle")
    var lazyImageInteractor = FZLazyImageInteractor()

    init(imageUrl: String) {
        if let imageURL = URL(string: imageUrl) {
            getImage(imagePath: imageURL)
        }
    }
    
    func getImage(imagePath: URL){
        
        lazyImageInteractor.getImage(imagePath: imagePath) { [weak self] (result: Result<UIImage, Error>) in
            switch result{
            case .success(let image):
                self?.downloadedImage = image
            case .failure(let error):
                debugPrint(error.localizedDescription)
            }
        }        
    }
}

