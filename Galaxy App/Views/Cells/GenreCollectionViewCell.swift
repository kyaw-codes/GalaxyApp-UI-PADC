//
//  GenreCollectionViewCell.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 21/07/2021.
//

import UIKit

class GenreCollectionViewCell: UICollectionViewCell {
    
    var genreName: String? {
        didSet {
            guard let genreName = genreName else { return }
            label.text = genreName
        }
    }
    
    private let label = UILabel(text: "", font: .poppinsLight, size: 16, color: .galaxyBlack)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        addSubview(label)
        label.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        
        layer.cornerRadius = frame.height / 2
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.galaxyLightBlack.cgColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
