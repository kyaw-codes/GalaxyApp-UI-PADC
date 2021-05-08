//
//  UIButton+Extensions.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 08/05/2021.
//

import UIKit

extension UIButton {
    
    convenience init(title: String,
                     font: UIFont.GalaxyFont = .poppinsRegular,
                     textSize: CGFloat = 18,
                     textColor: UIColor = .white,
                     backgroundColor: UIColor = .galaxyViolet,
                     cornerRadius: CGFloat = 8) {
        self.init(frame: .zero)
        
        self.setTitle(title, for: .normal)
        self.setTitleColor(textColor, for: .normal)
        self.backgroundColor = backgroundColor
        self.titleLabel?.font = font.font(of: textSize)
        self.layer.cornerRadius = cornerRadius
    }
}
