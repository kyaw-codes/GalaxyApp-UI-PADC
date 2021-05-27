//
//  ComboSetView.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 23/05/2021.
//

import UIKit

class ComboSetView: UIView {
    
    private let countButtonGroup = CountButtonGroup()
    
    private let titleLabel = UILabel(text: "Combo Set M", font: .poppinsRegular, size: 18, color: .galaxyBlack)
    
    private let descriptionLabel = UILabel(text: "Combo size M 22oz. Coke (X1) and medium pop corn (X1)", font: .poppinsRegular, size: 16, numberOfLines: 0, color: .galaxyLightBlack)
    
    private let priceLabel = UILabel(text: "0$", font: .poppinsRegular, size: 18, color: .galaxyBlack)

    init(title: String, description: String, unitPrice: Double) {
        super.init(frame: .zero)
        
        backgroundColor = .clear
        
        titleLabel.text = title
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.leading.top.equalToSuperview()
        }
        
        addSubview(countButtonGroup)
        countButtonGroup.snp.makeConstraints { (make) in
            make.trailing.bottom.equalToSuperview()
            make.width.equalTo(120)
            make.height.equalTo(36)
        }
        
        descriptionLabel.text = description
        addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).inset(-4)
            make.trailing.equalTo(countButtonGroup.snp.leading).inset(-14)
            make.bottom.equalToSuperview()
        }
        
        addSubview(priceLabel)
        priceLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(countButtonGroup.snp.top).inset(-10)
            make.centerX.equalTo(countButtonGroup)
        }
        
        countButtonGroup.onCountValueUpdate = { [weak self] count in
            self?.priceLabel.text = "\(unitPrice * Double(count))$"
        }
        
        isUserInteractionEnabled = true
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

}
