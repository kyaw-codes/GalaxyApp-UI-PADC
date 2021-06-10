//
//  PaymentMethodCell.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 27/05/2021.
//

import UIKit

class PaymentMethodCell: UICollectionViewCell {
    
    public struct ViewModel {
        var image: UIImage?
        var title: String
        var subtitle: String
    }
    
    var viewModel: ViewModel? {
        didSet {
            imageView.image = viewModel?.image?
                .withRenderingMode(.alwaysOriginal)
                .withTintColor(.seatReserved)
    
            titleLabel.text = viewModel?.title
            subtitleLabel.text = viewModel?.subtitle
        }
    }
    
    private let imageView = UIImageView()
    private let titleLabel = UILabel(text: "", font: .poppinsRegular, size: 18, color: .galaxyBlack)
    private let subtitleLabel = UILabel(text: "", font: .poppinsRegular, size: 15, color: .seatReserved)
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        imageView.contentMode = .scaleAspectFit

        let innerSV = UIStackView(subViews: [titleLabel, subtitleLabel], axis: .vertical, spacing: 4)
        
        let imageContainerView = UIView()
        imageContainerView.addSubview(imageView)
        
        imageView.snp.makeConstraints { (make) in
            make.width.height.equalToSuperview().multipliedBy(0.65)
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
