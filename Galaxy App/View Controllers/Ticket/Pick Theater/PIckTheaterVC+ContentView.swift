//
//  PIckTheater+ContentView.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 21/05/2021.
//

import UIKit

extension PickTheaterVC {
    
    class ContentView: UIScrollView {
        
        // MARK: - Properties
        
        var handleNextTap: (() -> Void)?
        
        // MARK: - Views
        
        private var availableMovieTypes = [OutlineButton]()
        private var availableTimesForFirstRow = [OutlineButton]()
        private var availableTimesForSecondRow = [OutlineButton]()
        
        private var firstRow: UIStackView?
        private var secondRow: UIStackView?
        private var thirdRow: UIStackView?
        
        private let nextButton = CTAButton(title: "Next")
        
        private var containerSV: UIStackView?
        
        // MARK: - Lifecycles
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            backgroundColor = .white
            layer.cornerRadius = 30
            layer.maskedCorners = CACornerMask.init(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMinYCorner)
            alwaysBounceVertical = true
            showsVerticalScrollIndicator = false
            
            setupViews()
            
            nextButton.addTarget(self, action: #selector(onNextTapped), for: .touchUpInside)
        }
        
        // MARK: - Layout Views
        
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
        
        // MARK: - Private Helpers
        
        private func createSectionTitleLabel(_ text: String) -> UILabel {
            return UILabel(text: text, font: .poppinsSemiBold, size: 20, numberOfLines: 1, color: .galaxyBlack)
        }
        
        private func createOutlineButtons(_ titles: String...) -> [OutlineButton] {
            titles.map { (title) -> OutlineButton in
                OutlineButton(title: title) { (btn) in
                    btn.setTitleColor(.galaxyBlack, for: .normal)
                    btn.snp.makeConstraints { (make) in
                        make.height.equalTo(50)
                    }
                    btn.layer.borderWidth = 1
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
            button.layer.borderColor = UIColor.seatAvailable.cgColor
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
        
        // MARK: - Action Handlers
        
        @objc private func onAvailableMovieInButtonTapped(_ sender: OutlineButton) {
            handleButtonTap(sender, searchIn: availableMovieTypes)
        }
        
        @objc private func onGoldenCityTimeButtonTapped(_ sender: OutlineButton) {
            handleButtonTap(sender, searchIn: availableTimesForFirstRow)
        }
        
        @objc private func onWestPointTimeButtonTapped(_ sender: OutlineButton) {
            handleButtonTap(sender, searchIn: availableTimesForSecondRow)
        }
        
        @objc private func onNextTapped() {
            handleNextTap?()
        }
        
        required init?(coder: NSCoder) {
            fatalError()
        }
    }
}
