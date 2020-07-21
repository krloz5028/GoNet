//
//  Extensions.swift
//  GoNet
//
//  Created by Carlos Ruiz on 20/07/20.
//  Copyright © 2020 CERR. All rights reserved.
//

import UIKit

let imageCache = NSCache<NSString, UIImage>()
extension UIImageView {
    func setImage(withUrl url : URL) {
        self.image = nil

        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString)  {
            self.image = cachedImage
            return
        }

        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            if error != nil {
                print(error!)
                return
            }

            DispatchQueue.main.async {
                if let image = UIImage(data: data!) {
                    imageCache.setObject(image, forKey: url.absoluteString as NSString)
                    self.image = image
                }
            }

        }).resume()
    }
}
