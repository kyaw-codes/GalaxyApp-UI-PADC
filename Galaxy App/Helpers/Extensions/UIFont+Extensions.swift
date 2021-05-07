//
//  UIFont+Extensions.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 06/05/2021.
//

import UIKit

extension UIFont {
    
    enum GalaxyFont: String {
        case poppinsThin = "Poppins-Thin"
        case poppinsLight = "Poppins-Light"
        case poppinsRegular = "Poppins-Regular"
        case poppinsMedium = "Poppins-Medium"
        case poppinsSemiBold = "Poppins-SemiBold"
        case poppinsBold = "Poppins-Bold"
        
        func font(of size: CGFloat) -> UIFont {
            guard let font = UIFont(name: self.rawValue, size: size) else {
                fatalError("Failed to load font named \(self.rawValue) in the project.")
            }
            return font
        }
    }
}

