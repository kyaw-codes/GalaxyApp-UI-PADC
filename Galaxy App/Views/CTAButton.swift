//
//  CTAButton.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 02/06/2021.
//

import UIKit

class CTAButton: UIButton {
    
    init(title: String, completion: ((UIButton) -> Void)? = nil) {
        super.init(frame: .zero)
        
        self.setTitle(title, for: .normal)
        self.setTitleColor(.white, for: .normal)
        self.backgroundColor = .galaxyViolet
        self.titleLabel?.font = UIFont.GalaxyFont.poppinsRegular.font(of: 18)
        self.layer.cornerRadius = 8
        
        self.layer.shadowColor = UIColor.galaxyViolet.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 5)
        self.layer.shadowRadius = 10
        self.layer.shadowOpacity = 0.6
        
        self.snp.makeConstraints { (make) in
            make.height.equalTo(60)
        }
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

}
