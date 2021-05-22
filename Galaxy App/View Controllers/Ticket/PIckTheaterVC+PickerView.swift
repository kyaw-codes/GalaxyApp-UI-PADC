//
//  PIckTheater+PickerView.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 21/05/2021.
//

import UIKit

extension PickTheaterVC {
    
    class PickerView: UIScrollView {
        
        private var availableMovieTypes = [OutlineButton]()
        private var availableTimesForFirstRow = [OutlineButton]()
        private var availableTimesForSecondRow = [OutlineButton]()
        
        private var firstRow: UIStackView?
        private var secondRow: UIStackView?
        private var thirdRow: UIStackView?
        
        private let nextButton = UIButton(title: "Next",
                                          font: .poppinsMedium,
                                          textSize: 18,
                                          textColor: .white,
                                          backgroundColor: .galaxyViolet) { btn in
            
            btn.layer.shadowColor = UIColor.galaxyViolet.cgColor
            btn.layer.shadowOffset = CGSize(width: 4, height: 5)
            btn.layer.shadowRadius = 10
            btn.layer.shadowOpacity = 0.6

            btn.snp.makeConstraints { (make) in
                make.height.equalTo(60)
            }
        }
        
        private var containerSV: UIStackView?
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            backgroundColor = .white
            layer.cornerRadius = 30
            layer.maskedCorners = CACornerMask.init(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMinYCorner)
            alwaysBounceVertical = true
            showsVerticalScrollIndicator = false
            
            setupViews()
        }
        
        private func setupViews() {
            availableMovieTypes = createOutlineButtons("2D", "3D", "IMAX")
            availableMovieTypes.forEach { $0.addTarget(self, action: #selector(onAvailableMovieInButtonTapped(_:)), for: .touchUpInside) }
            
            availableTimesForFirstRow = createOutlineButtons("9:30 AM", "11:45 AM", "3:30 PM", "5:00 PM", "7:00 PM", "9:30 PM")
            availableTimesForFirstRow.forEach { $0.addTarget(self, action: #selector(onGoldenCityTimeButtonTapped(_:)), for: .touchUpInside) }
            
            availableTimesForSecondRow = createOutlineButtons("9:30 AM", "11:45 AM", "3:30 PM", "5:00 PM", "7:00 PM", "9:30 PM")
            availableTimesForSecondRow.forEach { $0.addTarget(self, action: #selector(onWestPointTimeButtonTapped(_:)), for: .touchUpInside) }

            setupFirstRow()
            setupSeconRow()
            setupThirdRow()
            setupContainerView()
        }
        
        private func setupFirstRow() {
            let titleLabel = createSectionTitleLabel("Available In")
            let buttonsSV = UIStackView(subViews: availableMovieTypes, axis: .horizontal, spacing: 20)
            buttonsSV.distribution = .fillEqually
            buttonsSV.isLayoutMarginsRelativeArrangement = true
            buttonsSV.layoutMargins = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
            
            firstRow = UIStackView(subViews: [titleLabel, buttonsSV], axis: .vertical, spacing: 26)
        }
        
        private func setupSeconRow() {
            let titleLabel = createSectionTitleLabel("GC: Golden City")

            let firstButtonsSv = UIStackView(subViews: Array(availableTimesForFirstRow[0..<3]), axis: .horizontal, spacing: 20)
            let secondButtonsSv = UIStackView(subViews: Array(availableTimesForFirstRow[3..<availableTimesForFirstRow.count]), axis: .horizontal, spacing: 20)

            [firstButtonsSv, secondButtonsSv].forEach {
                $0.distribution = .fillEqually
                $0.isLayoutMarginsRelativeArrangement = true
                $0.layoutMargins = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
            }
            
            secondRow = UIStackView(subViews: [titleLabel, firstButtonsSv, secondButtonsSv], axis: .vertical, spacing: 26)
            secondRow?.setCustomSpacing(20, after: firstButtonsSv)
        }
        
        private func setupThirdRow() {
            let titleLabel = createSectionTitleLabel("GC: West Point")

            let firstButtonsSv = UIStackView(subViews: Array(availableTimesForSecondRow[0..<3]), axis: .horizontal, spacing: 20)
            let secondButtonsSv = UIStackView(subViews: Array(availableTimesForSecondRow[3..<availableTimesForSecondRow.count]), axis: .horizontal, spacing: 20)

            [firstButtonsSv, secondButtonsSv].forEach {
                $0.distribution = .fillEqually
                $0.isLayoutMarginsRelativeArrangement = true
                $0.layoutMargins = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
            }
            
            thirdRow = UIStackView(subViews: [titleLabel, firstButtonsSv, secondButtonsSv], axis: .vertical, spacing: 26)
            thirdRow?.setCustomSpacing(20, after: firstButtonsSv)
        }
        
        private func setupContainerView() {
            containerSV = UIStackView(subViews: [firstRow!,secondRow!, thirdRow!, nextButton, UIView()], axis: .vertical, spacing: 34)
            
            addSubview(containerSV!)
            containerSV!.snp.makeConstraints { (make) in
                make.top.equalToSuperview().inset(30)
                make.leading.trailing.bottom.equalToSuperview().inset(20)
                make.centerX.equalToSuperview()
            }
        }
        
        private func createSectionTitleLabel(_ text: String) -> UILabel {
            return UILabel(text: text, font: .poppinsSemiBold, size: 20, numberOfLines: 1, color: .galaxyBlack)
        }
        
        private func createOutlineButtons(_ titles: String...) -> [OutlineButton] {
            titles.map { (title) -> OutlineButton in
                OutlineButton(title: title) { (btn) in
                    btn.snp.makeConstraints { (make) in
                        make.height.equalTo(50)
                    }
                    btn.layer.borderWidth = 0.5
                }
            }
        }
        
        @objc private func onAvailableMovieInButtonTapped(_ sender: OutlineButton) {
            handleButtonTap(sender, searchIn: availableMovieTypes)
        }
        
        @objc private func onGoldenCityTimeButtonTapped(_ sender: OutlineButton) {
            handleButtonTap(sender, searchIn: availableTimesForFirstRow)
        }
        
        @objc private func onWestPointTimeButtonTapped(_ sender: OutlineButton) {
            handleButtonTap(sender, searchIn: availableTimesForSecondRow)
        }
        
        private func handleButtonTap(_ button: OutlineButton, searchIn array: [OutlineButton]) {
            if array.contains(button) {
                array.forEach {
                    if $0 === button {
                        if $0.backgroundColor == UIColor.galaxyViolet {
                            deselectButton($0)
                        } else {
                            selectButton($0)
                        }
                    } else {
                        deselectButton($0)
                    }
                }
            }
        }
        
        private func selectButton(_ button: UIButton) {
            button.backgroundColor = .galaxyViolet
            button.setTitleColor(.white, for: .normal)
            button.layer.borderColor = UIColor.clear.cgColor
        }
        
        private func deselectButton(_ button: UIButton) {
            button.backgroundColor = .white
            button.setTitleColor(.galaxyBlack, for: .normal)
            button.layer.borderColor = UIColor.galaxyLightBlack.cgColor
        }
        
        required init?(coder: NSCoder) {
            fatalError()
        }
    }
}
