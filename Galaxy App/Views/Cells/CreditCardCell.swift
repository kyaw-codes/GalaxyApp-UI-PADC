//
//  CreditCardCell.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 28/05/2021.
//

import UIKit
import Gemini

class CreditCardCell: GeminiCell {
    
    var creditCard: CreditCard? {
        didSet {
            guard let cardData = creditCard else { return }
            
            let lastFourDigit = getLastFourDigit(of: cardData.cardNo)
            cardNoLabel.text = "* * * *  * * * *  * * * *  \(lastFourDigit)"
            
            guard let nameLabel = nameSV?.arrangedSubviews.last as? UILabel else { return }
            nameLabel.text = cardData.cardHolder

            guard let expireDateLabel = expireDateSV?.arrangedSubviews.last as? UILabel else { return }
            expireDateLabel.text = cardData.expireDate.stringValue(in: "MM/dd")
        }
    }
    
    private let visaLogo = UIImageView(image: #imageLiteral(resourceName: "visa"), contentMode: .scaleAspectFit)
    private let moreButton = UIButton(iconImage: #imageLiteral(resourceName: "more"))
    
    private var nameSV: UIStackView?
    private var expireDateSV: UIStackView?
    
    private let cardNoLabel = UILabel(text: "", font: .poppinsRegular, size: 22, numberOfLines: 1, color: .white, alignment: .center)

    let cardBackground = UIImageView(image: #imageLiteral(resourceName: "card_background"), contentMode: .scaleAspectFill)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(cardBackground)
        cardBackground.snp.makeConstraints { (make) in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
        
        visaLogo.snp.makeConstraints { (make) in
            make.height.equalTo(30)
            make.width.equalTo(40)
        }
        
        moreButton.imageEdgeInsets = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
        let topSV = UIStackView(arrangedSubviews: [visaLogo, UIView(), moreButton])
        topSV.alignment = .top
        
        nameSV = createCardInfoSV(title: "Lily Johnson", subTitle: "Card Holder")
        expireDateSV = createCardInfoSV(title: Date().stringValue(in: "MM/dd"), subTitle: "Expires")
        let bottomSV = UIStackView(arrangedSubviews: [nameSV!, UIView(), expireDateSV!])
        
        let parentSV = UIStackView(subViews: [topSV, cardNoLabel, UIView(), bottomSV], axis: .vertical)
        parentSV.setCustomSpacing(10, after: topSV)
        
        addSubview(parentSV)
        parentSV.snp.makeConstraints { (make) in
            make.leading.trailing.top.bottom.equalToSuperview().inset(20)
        }
        
        layer.cornerRadius = 8
        layer.masksToBounds = true
    }
    private func createCardInfoSV(title: String, subTitle: String) -> UIStackView {
        let titleLabel = UILabel(text: title, font: .poppinsRegular, size: 20, numberOfLines: 1, color: .white)
        let subtitleLabel = UILabel(text: subTitle.uppercased(), font: .poppinsLight, size: 16, numberOfLines: 1, color: .seatAvailable)
        return UIStackView(subViews: [subtitleLabel, UIView(), titleLabel], axis: .vertical, spacing: 2)
    }
    
    private func getLastFourDigit(of cardNo: String) -> String {
        if cardNo.count == 16 {
            return cardNo[12...15]
        } else {
            return "0000"
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
