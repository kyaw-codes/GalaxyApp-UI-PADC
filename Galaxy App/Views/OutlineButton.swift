//
//  OutlineButton.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 07/05/2021.
//

import UIKit

class OutlineButton: UIButton, GalaxyButton {
    
    var titleFont: UIFont = UIFont.GalaxyFont.poppinsMedium.font(of: 18) {
        didSet {
            self.titleLabel?.font = titleFont
        }
    }

    var titleColor: UIColor = .black {
        didSet {
            self.setTitleColor(titleColor, for: .normal)
        }
    }
    
    var outlineColor: UIColor = .galaxyLightBlack {
        didSet {
            self.layer.borderColor = outlineColor.cgColor
        }
    }
    
    var outlineWidth: CGFloat = 1 {
        didSet {
            self.layer.borderWidth = outlineWidth
        }
    }
    
    var cornerRadius: CGFloat = 8 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    var buttonColor: UIColor = .clear {
        didSet {
            self.backgroundColor = buttonColor
        }
    }
    
    init(title: String) {
        super.init(frame: .zero)

        self.setTitle(title, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        self.backgroundColor = buttonColor
        self.titleLabel?.font = titleFont
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = outlineWidth
        self.layer.borderColor = outlineColor.cgColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
