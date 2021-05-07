//
//  GalaxyButton.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 07/05/2021.
//

import UIKit

protocol GalaxyButton {
    
    var titleFont: UIFont { get set }

    var titleColor: UIColor { get set }
    
    var buttonColor: UIColor { get set }
    
    var outlineColor: UIColor { get set }
    
    var outlineWidth: CGFloat { get set }
    
    var cornerRadius: CGFloat { get set }
}
