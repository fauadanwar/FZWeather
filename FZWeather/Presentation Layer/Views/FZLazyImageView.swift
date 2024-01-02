//
//  FZLazyImageView.swift
//  FZWeather
//
//  Created by Fauad Anwar on 17/10/22.
//

import SwiftUI

struct FZLazyImageView: View {
    @ObservedObject var lazyImagePresenter: FZLazyImagePresenter
    
    var body: some View {
        VStack{
            Image(uiImage: lazyImagePresenter.downloadedImage!)
                .resizable()
                .scaledToFit()
                .frame(width: 75, height: 75)
        }
    }
}

struct FZLazyImageView_Previews: PreviewProvider {
    static var previews: some View {
        FZLazyImageView(lazyImagePresenter: FZLazyImagePresenter(imageUrl: ""))
    }
}
