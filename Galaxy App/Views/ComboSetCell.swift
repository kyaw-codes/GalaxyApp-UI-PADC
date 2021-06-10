//
//  ComboSetCell.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 10/06/2021.
//

import UIKit

class ComboSetCell: UICollectionViewCell {
    
    public struct ViewModel {
        var title: String
        var description: String
        var unitPrice: Double
    }
    
    var viewModel: ViewModel? {
        didSet {
            titleLabel.text = viewModel?.title
            descriptionLabel.text = viewModel?.description
        }
    }
    
    private let countButtonGroup = CountButtonGroup()
    
    private let titleLabel = UILabel(text: "", font: .poppinsRegular, size: 18, color: .galaxyBlack)
    
    private let descriptionLabel = UILabel(text: "", font: .poppinsRegular, size: 15, numberOfLines: 0, color: .galaxyLightBlack)
    
    private let priceLabel = UILabel(text: "0$", font: .poppinsRegular, size: 18, color: .galaxyBlack)

    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        backgroundColor = .clear
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.leading.top.equalToSuperview()
        }
        
        addSubview(countButtonGroup)
        countButtonGroup.snp.makeConstraints { (make) in
            make.trailing.bottom.equalToSuperview()
            make.width.equalTo(100)
            make.height.equalTo(36)
        }
        
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
            guard let unitPrice = self?.viewModel?.unitPrice else { return }
            self?.priceLabel.text = "\(unitPrice * Double(count))$"
        }
        
        isUserInteractionEnabled = true
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
}
