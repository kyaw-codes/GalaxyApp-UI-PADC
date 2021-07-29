//
//  TimeSlotVC+Layout.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 28/07/2021.
//

import UIKit

extension TimeSlotVC {
    
    func setupViews() {
        scrollView.layer.cornerRadius = 30
        scrollView.layer.masksToBounds = true
        scrollView.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMinYCorner)
        scrollView.showsVerticalScrollIndicator = false
        
        let backgroundView = UIView(backgroundColor: .white)
        view.addSubview(backgroundView)
        backgroundView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.6)
        }

        view.addSubview(backButton)
        backButton.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(18)
            make.leading.equalToSuperview().inset(20)
        }
        
        view.addSubview(calendarCollectionView)
        calendarCollectionView.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(backButton.snp.bottom).inset(-18)
            make.height.equalTo(80)
        }
        
        view.addSubview(scrollView)
        view.addSubview(nextButton)

        scrollView.snp.makeConstraints { make in
            make.top.equalTo(calendarCollectionView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(nextButton.snp.top)
        }
        
        scrollView.addSubview(movieTypesCollectionView)
        movieTypesCollectionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalTo(30)
            make.centerX.equalToSuperview()
            make.height.equalTo(130)
        }
        
        scrollView.addSubview(timeSlotsCollectionView)
        timeSlotsCollectionView.snp.makeConstraints { make in
            make.top.equalTo(movieTypesCollectionView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.equalTo(470)
        }

        nextButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        view.addSubview(spinner)
        spinner.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
}
