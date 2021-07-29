//
//  CheckoutVC+Layout.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 28/07/2021.
//

import UIKit

extension CheckoutVC {
    
    func setupViews() {
        view.addSubview(backButton)
        backButton.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(18)
            make.leading.equalToSuperview().inset(24)
        }
        
        view.addSubview(spinner)
        spinner.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        
        setupHeaderSV()
        setupCardCollectionSV()
        setupFromSV()
        
        [headerSV!, cardCollectionSV!, formSV!].forEach { contentStackView.addArrangedSubview($0) }
        contentStackView.setCustomSpacing(36, after: cardCollectionSV!)
    }
    
    private func setupHeaderSV() {
        let subTitle = UILabel(text: "Payment amount", font: .poppinsRegular, size: 16, color: .seatReserved)
        headerSV = UIStackView(subViews: [subTitle, paymentAmountLabel], axis: .vertical, spacing: 8)
        headerSV?.isLayoutMarginsRelativeArrangement = true
        headerSV?.layoutMargins = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
    }
    
    private func setupCardCollectionSV() {
        collectionView.snp.makeConstraints { (make) in
            make.height.equalTo(200)
        }
        
        cardCollectionSV = UIStackView(arrangedSubviews: [collectionView])
    }
    
    private func setupFromSV() {
        let addNewCardSV = UIStackView(arrangedSubviews: [addNewCardButton, UIView()])
        formSV = UIStackView(subViews: [addNewCardSV, confirmButton], axis: .vertical, spacing: 26)
        
        formSV?.isLayoutMarginsRelativeArrangement = true
        formSV?.layoutMargins = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        formSV?.setCustomSpacing(30, after: addNewCardSV)
    }
}
