//
//  UILabel+Extensions.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 06/05/2021.
//

import UIKit

extension UILabel {
    
    convenience init(text: String, font: UIFont.GalaxyFont, size: CGFloat = UIFont.labelFontSize, numberOfLines: Int = 1, color: UIColor = .white) {
        self.init()
        
        self.text = text
        self.font = font.font(of: size)
        self.numberOfLines = numberOfLines
        self.textColor = color
    }
}
