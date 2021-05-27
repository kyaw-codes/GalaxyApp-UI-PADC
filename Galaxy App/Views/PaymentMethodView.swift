//
//  PaymentMethodView.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 27/05/2021.
//

import UIKit

class PaymentMethodView: UIView {
    
    private let imageView = UIImageView()
    private let titleLabel = UILabel(text: "", font: .poppinsRegular, size: 20, color: .galaxyBlack)
    private let subtitleLabel = UILabel(text: "", font: .poppinsRegular, size: 16, color: .seatReserved)
    
    init(image: UIImage?, title: String, subTitle: String) {
        super.init(frame: .zero)
        
        imageView.image = image?
            .withRenderingMode(.alwaysOriginal)
            .withTintColor(.seatReserved)
        
        imageView.contentMode = .scaleAspectFit
        
        titleLabel.text = title
        subtitleLabel.text = subTitle
        
        let innerSV = UIStackView(subViews: [titleLabel, subtitleLabel], axis: .vertical, spacing: 4)
        
        let imageContainerView = UIView()
        imageContainerView.addSubview(imageView)
        
        imageView.snp.makeConstraints { (make) in
            make.width.height.equalToSuperview().multipliedBy(0.7)
            make.centerY.equalToSuperview()
        }

        let outerSV = UIStackView(subViews: [imageContainerView, innerSV], axis: .horizontal, spacing: 0)
        
        addSubview(outerSV)
        outerSV.snp.makeConstraints { (make) in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
        
        backgroundColor = .white
    }
    
    override func layoutSubviews() {
        titleLabel.snp.makeConstraints { (make) in
            make.width.equalTo(frame.width * 0.84)
        }
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

}
