//
//  HomeVC+Layout.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 29/07/2021.
//

import UIKit

extension HomeVC {

    func setupView() {
        view.addSubview(spinner)
        spinner.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        
        setupNavBar()
        setupCollectionView()
    }
    
    private func setupNavBar() {
        let searchButton = UIButton(iconImage: #imageLiteral(resourceName: "search"))
        let sv = UIStackView(arrangedSubviews: [menuButton, UIView(), searchButton])
        navView.addSubview(sv)
        sv.snp.makeConstraints { (make) in
            make.top.equalToSuperview().inset(40)
            make.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        view.addSubview(navView)
        navView.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(100)
        }
    }
    
    private func setupCollectionView() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(navView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}
