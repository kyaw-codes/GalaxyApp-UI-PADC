//
//  UIImageView+Extensions.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 06/05/2021.
//

import UIKit

extension UIImageView {
    
    
    /// A convenience initializer to accelerate working with UIImageView
    /// - Parameters:
    ///   - image: The image to display
    ///   - contentMode: The rendering mode for the image. Default is scale aspect fit
    convenience init(image: UIImage?, contentMode: ContentMode = .scaleAspectFit) {
        self.init(image: image)
        
        self.contentMode = contentMode
    }
}
