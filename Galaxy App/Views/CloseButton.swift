//
//  CloseButton.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 01/06/2021.
//

import UIKit

class CloseButton: UIButton {

    init() {
        super.init(frame: .zero)
        
        let symbolConfig = UIImage.SymbolConfiguration(font: .systemFont(ofSize: 24, weight: .medium))
        let icon = UIImage(systemName: "xmark", withConfiguration: symbolConfig)?.withRenderingMode(.alwaysOriginal).withTintColor(.galaxyBlack)
        
        self.setImage(icon, for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

}
