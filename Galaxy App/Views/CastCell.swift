//
//  CastCell.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 20/05/2021.
//

import UIKit

class CastCell: UICollectionViewCell {
    
    var cast: Cast? {
        didSet {
            guard let cast = cast else { return }
            imageView.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/original\(cast.profilePath ?? "")"))
            nameLabel.text = cast.name ?? "No Name"
        }
    }
    
    private let imageView = UIImageView(image: nil, contentMode: .scaleAspectFill)
    private let nameLabel = UILabel(text: "", font: .poppinsLight, size: 14, numberOfLines: 2, color: .galaxyBlack, alignment: .center)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
            make.width.height.equalTo(frame.width - 18)
        }
        imageView.layer.cornerRadius = (frame.width - 18) / 2
        imageView.clipsToBounds = true
        
        addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(imageView.snp.bottom).inset(-2)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
