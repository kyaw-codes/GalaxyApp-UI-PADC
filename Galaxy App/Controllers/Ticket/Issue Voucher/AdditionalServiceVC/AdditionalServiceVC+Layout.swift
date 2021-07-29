//
//  AdditionalServiceVC+Layout.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 28/07/2021.
//

import UIKit

extension AdditionalServiceVC {
    
    func setupViews() {
        view.addSubview(backButton)
        backButton.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(18)
            make.leading.equalToSuperview().inset(24)
        }
        
        view.addSubview(collectionView)
        view.addSubview(payButton)

        collectionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(backButton.snp.bottom).inset(-10)
            make.bottom.equalTo(payButton.snp.top)
        }
        
        payButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        view.addSubview(spinner)
        spinner.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
}
