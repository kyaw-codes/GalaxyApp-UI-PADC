//
//  SeatCell.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 23/05/2021.
//

import UIKit

class SeatCell: UICollectionViewCell {
        
    var seat: Seat? {
        didSet {
            guard let data = seat else { return }
            label.text = data.seatNo
            seatView.backgroundColor = data.isAvailable ? .seatAvailable : .seatReserved
            isUserInteractionEnabled = data.isAvailable
        }
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                seatView.backgroundColor = .galaxyViolet
                label.textColor = .white
            } else {
                seatView.backgroundColor = .seatAvailable
                label.textColor = .clear
            }
        }
    }
    
    let seatView = UIView(backgroundColor: .seatAvailable)
    private let label = UILabel(text: "1", font: .poppinsRegular, size: 14, color: .clear)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .clear
        
        addSubview(seatView)
        seatView.snp.makeConstraints { (make) in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
        
        addSubview(label)
        label.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(4)
        }
        
        seatView.layer.cornerRadius = frame.width / 2
        seatView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
