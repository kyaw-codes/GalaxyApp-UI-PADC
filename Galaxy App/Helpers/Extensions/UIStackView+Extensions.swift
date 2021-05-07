//
//  UIStackView+Extensions.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 06/05/2021.
//

import UIKit

extension UIStackView {
    
    convenience init(subViews: [UIView], axis: NSLayoutConstraint.Axis, spacing: CGFloat = 8) {
        self.init(arrangedSubviews: subViews)
        
        self.axis = axis
        self.spacing = spacing
    }
}
