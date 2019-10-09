//
//  ImageLoader.swift
//  Video Game Releases
//
//  Created by George on 08/10/2019.
//  Copyright © 2019 George. All rights reserved.
//

import SwiftUI

class ImageLoader: ObservableObject {
    
    private static let imageCache = NSCache<AnyObject, AnyObject>()
    
    @Published var image: UIImage? = nil
    
    public func downloadImage(url: URL) {
        
        let urlString = url.absoluteString // Retrieve the absoulte string of the url
        
        if let imageFromCache = ImageLoader.imageCache.object(forKey: urlString as AnyObject) as? UIImage { // Then retrieve the image from cache if it exists
            self.image = imageFromCache
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, res, error) in // If image not in cache using the url if it exists, use URLSession to reetreive the image using the url
            guard let data = data, let image = UIImage(data: data) else {
                return
            }
            DispatchQueue.main.async { [weak self] in // Then assign it to cache and assign it to image proprety
                ImageLoader.imageCache.setObject(image, forKey: urlString as AnyObject)
                self?.image = image
            }
        }.resume()
    }
    
}
