//
//  MainVC+layout.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 24/07/2021.
//

import UIKit

extension MainVC {
    
    func layoutViews() {
        add(homeVC)
        homeView?.snp.makeConstraints({ (make) in
            make.width.top.bottom.equalToSuperview()
            contentLeadingConstraint = make.leading.equalToSuperview().constraint
        })

        add(sideMenuVC)
        sideMenuVC.user = homeVC.user
        sideMenuView?.snp.makeConstraints({ (make) in
            make.top.bottom.equalToSuperview()
            make.width.equalTo(menuWidth)
            menuLeadingConstraint = make.leading.equalToSuperview().inset(-menuWidth).constraint
        })

        view.addSubview(spinner)
        spinner.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
    
    private func add(_ vc: UIViewController) {
        addChild(vc)
        view.addSubview(vc.view)
    }
}
