//
//  TabHeaderCell.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 05/06/2021.
//

import UIKit

class TabHeaderCell: UICollectionViewCell {
    
    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    
    override var isHighlighted: Bool {
        didSet {
            titleLabel.textColor = isSelected ? .galaxyViolet : .galaxyBlack
        }
    }
    
    override var isSelected: Bool {
        didSet {
            titleLabel.textColor = isSelected ? .galaxyViolet : .galaxyBlack
        }
    }
    
    private let titleLabel = UILabel(text: "", font: .poppinsMedium, size: 18, color: .galaxyBlack, alignment: .center)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .clear
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.centerX.centerY.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
