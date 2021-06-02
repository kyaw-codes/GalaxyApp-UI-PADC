//
//  SocialButton.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 02/06/2021.
//

import UIKit

class SocialButton: UIView {
    
    private let titleLabel = UILabel(text: "", font: .poppinsRegular, size: 20, numberOfLines: 1, color: .galaxyLightBlack)
    
    private let imageView = UIImageView(image: nil, contentMode: .scaleAspectFit)
    
    private var onTap: ((SocialButton) -> Void)?
    
    init(title: String, icon: UIImage?, onTap: ((SocialButton) -> Void)? = nil) {
        super.init(frame: .zero)
        
        self.onTap = onTap
        
        titleLabel.text = title
        imageView.image = icon
        
        let sv = UIStackView(arrangedSubviews: [imageView, titleLabel, UIView()])
        sv.distribution = .equalCentering
        
        addSubview(sv)
        sv.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(30)
        }
        
        self.snp.makeConstraints { (make) in
            make.height.equalTo(60)
        }
        
        layer.cornerRadius = 8
        layer.borderColor = UIColor.galaxyLightBlack.withAlphaComponent(0.5).cgColor
        layer.borderWidth = 0.5
        
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapped)))
    }
    
    @objc private func handleTapped() {
        onTap?(self)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
}
