//
//  ProfileCell.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 08/05/2021.
//

import UIKit
import SnapKit

class ProfileCell: UICollectionViewCell {
    
    private let profileImage = UIImageView(image: #imageLiteral(resourceName: "profile"), contentMode: .scaleAspectFill)
    private let greetingLabel = UILabel(text: "Hi Craig!", font: .poppinsSemiBold, size: 26, color: .galaxyBlack)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    private func setupViews() {
        addSubview(profileImage)
        profileImage.snp.makeConstraints { (make) in
            make.leading.top.bottom.equalToSuperview()
            make.width.equalTo(self.frame.height)
        }
        profileImage.layer.cornerRadius = frame.height / 2
        profileImage.clipsToBounds = true
        
        addSubview(greetingLabel)
        greetingLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.leading.equalTo(profileImage.snp.trailing).inset(-20)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
