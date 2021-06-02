//
//  BackButton.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 01/06/2021.
//

import UIKit

class BackButton: UIButton {

    init(iconColor: UIColor = .galaxyBlack) {
        super.init(frame: .zero)
        
        let symbolConfig = UIImage.SymbolConfiguration(font: .systemFont(ofSize: 28, weight: .medium))
        let icon = UIImage(systemName: "chevron.backward", withConfiguration: symbolConfig)?.withRenderingMode(.alwaysOriginal).withTintColor(iconColor)
        
        self.setImage(icon, for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

}
