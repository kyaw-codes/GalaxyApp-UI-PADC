//
//  PromocodeCell.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 27/05/2021.
//

import UIKit

class PromocodeCell: UICollectionViewCell {
    
    let textField: UITextField = {
        let tf = UITextField()
        tf.font = UIFont.GalaxyFont.poppinsRegular.font(of: 20)
        tf.textColor = .galaxyBlack

        tf.attributedPlaceholder = NSAttributedString(
            string: "Enter promo code",
            attributes: [
                NSAttributedString.Key.foregroundColor : UIColor.seatReserved,
                NSAttributedString.Key.font : UIFont.GalaxyFont.poppinsItalic.font(of: 20)])

        tf.autocorrectionType = .no
        tf.autocapitalizationType = .none
        return tf
    }()
    
    private let additionalInfoLabel = UILabel(text: "Don't have any promo code ?", font: .poppinsRegular, size: 16, color: .seatReserved)
    
    private let underlineView = UIView(backgroundColor: .seatAvailable)
    private let getItNowLabel = UILabel(text: "Get it now", font: .poppinsRegular, size: 16, color: .galaxyBlack)
    var subTotlaLabel = UILabel(text: "Sub totla : 40$", font: .poppinsMedium, size: 16, color: .galaxyGreen)

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(textField)
        textField.snp.makeConstraints { (make) in
            make.leading.trailing.top.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.3)
        }
        
        addSubview(underlineView)
        underlineView.snp.makeConstraints { (make) in
            make.top.equalTo(textField.snp.bottom).inset(-10)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
        
        addSubview(additionalInfoLabel)
        additionalInfoLabel.snp.makeConstraints { (make) in
            make.top.equalTo(underlineView.snp.bottom).inset(-10)
            make.leading.equalToSuperview()
        }
        
        addSubview(getItNowLabel)
        getItNowLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(additionalInfoLabel.snp.trailing).inset(-4)
            make.bottom.equalTo(additionalInfoLabel.snp.bottom)
        }
        
        addSubview(subTotlaLabel)
        subTotlaLabel.snp.makeConstraints { make in
            make.leading.bottom.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

}
