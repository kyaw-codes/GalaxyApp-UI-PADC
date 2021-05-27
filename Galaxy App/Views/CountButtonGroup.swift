//
//  CountButtonGroup.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 23/05/2021.
//

import UIKit

class CountButtonGroup: UIView {
    
    var onCountValueUpdate: ((Int) -> Void)?
    
    private var count: Int = 0
    
    private let addLabel = UILabel(text: "+", font: .poppinsRegular, size: 18, color: .galaxyBlack)
    private let subtractLabel = UILabel(text: "-", font: .poppinsRegular, size: 18, color: .galaxyBlack)
    private var countLabel = UILabel(text: "0", font: .poppinsRegular, size: 18, color: .seatAvailable, alignment: .center)
    
    private let leftView = UIView(backgroundColor: .clear)
    private let middleView = UIView(backgroundColor: .clear)
    private let rightView = UIView(backgroundColor: .clear)
    
    private let leftSeparatorView = UIView(backgroundColor: .seatAvailable)
    private let rightSeparatorView = UIView(backgroundColor: .seatAvailable)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        [leftView, middleView, rightView, leftSeparatorView, rightSeparatorView].forEach { addSubview($0) }

        leftView.addSubview(subtractLabel)
        middleView.addSubview(countLabel)
        rightView.addSubview(addLabel)
        
        layer.cornerRadius = 8
        layer.borderWidth = 1
        layer.borderColor = UIColor.seatAvailable.cgColor
        
        [leftView, rightView].forEach {
            $0.isUserInteractionEnabled = true
            $0.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onButtonTapped(_:))))
        }
        
        onCountValueUpdate?(count)
    }
    
    override func layoutSubviews() {
        layoutContainerViews()
        
        leftSeparatorView.snp.makeConstraints { (make) in
            make.centerX.equalTo(leftView.snp.trailing)
            make.width.equalTo(1)
            make.height.equalTo(frame.height)
        }
        
        rightSeparatorView.snp.makeConstraints { (make) in
            make.centerX.equalTo(rightView.snp.leading)
            make.width.equalTo(1)
            make.height.equalTo(frame.height)
        }

        [addLabel, subtractLabel, countLabel].forEach {
            $0.snp.makeConstraints { (make) in
                make.centerX.centerY.equalToSuperview()
            }
        }
    }
    
    private func layoutContainerViews() {
        leftView.snp.makeConstraints { (make) in
            make.leading.top.bottom.equalToSuperview()
            make.width.equalTo(frame.width / 3)
        }
        
        middleView.snp.makeConstraints { (make) in
            make.leading.equalTo(leftView.snp.trailing)
            make.top.bottom.equalToSuperview()
            make.width.equalTo(frame.width / 3)
        }
        
        
        rightView.snp.makeConstraints { (make) in
            make.top.bottom.trailing.equalToSuperview()
            make.width.equalTo(frame.width / 3)
        }
    }
    
    @objc private func onButtonTapped(_ sender: UITapGestureRecognizer) {
        guard let view = sender.view else { return }
        switch view {
        case leftView:
            // Subtract one
            updateCountlabel(by: -1)
        case rightView:
            updateCountlabel(by: 1)
        default:
            break
        }
    }
    
    private func updateCountlabel(by value: Int) {
        // Avoid negative count value
        if (count + value) >= 0 {
            count += value
            onCountValueUpdate?(count)
        }
        countLabel.text = String(count)
        countLabel.textColor = count == 0 ? .seatAvailable : .galaxyBlack
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
    
}
