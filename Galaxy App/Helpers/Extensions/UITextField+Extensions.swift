//
//  UITextField+Extensions.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 08/05/2021.
//

import UIKit

extension UITextField {
    
    convenience init(font: UIFont.GalaxyFont = .poppinsRegular,
                     placeholderText: String = "",
                     textSize: CGFloat,
                     keyboardType: UIKeyboardType = .default,
                     textFieldHeight: CGFloat = 20) {
        
        self.init(frame: .zero)
        
        self.font = font.font(of: textSize)
        self.autocapitalizationType = .none
        self.autocorrectionType = .no
        self.textColor = .galaxyBlack
        self.placeholder = placeholder
        self.keyboardType = keyboardType
    }
}
