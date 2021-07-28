//
//  CalendarCell.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 21/05/2021.
//

import UIKit

class CalendarCell: UICollectionViewCell {
    
    private let checkoutVM = GlobalVoucherModel.instance
    
    var calendar: CalendarVO? {
        didSet {
            guard let calendar = calendar else { return }
            dayLabel.text = calendar.date.dayOfWeek()
            dateLabel.text = calendar.date.getDay()
            
            if calendar.isSelected {
                dayLabel.textColor = .white
                dayLabel.font = UIFont.GalaxyFont.poppinsMedium.font(of: 20)
                
                dateLabel.textColor = .white
                dateLabel.font = UIFont.GalaxyFont.poppinsMedium.font(of: 26)
            } else {
                dayLabel.textColor = UIColor.white.withAlphaComponent(0.5)
                dayLabel.font = UIFont.GalaxyFont.poppinsLight.font(of: 18)
                
                dateLabel.textColor = UIColor.white.withAlphaComponent(0.5)
                dateLabel.font = UIFont.GalaxyFont.poppinsLight.font(of: 18)
            }
        }
    }
    
    var onDaySelected: ((CalendarVO) -> Void)?
    
    private let dayLabel = UILabel(text: "", font: .poppinsLight, size: 18, numberOfLines: 1, color: UIColor.white.withAlphaComponent(0.5), alignment: .center)
    private let dateLabel = UILabel(text: "", font: .poppinsLight, size: 18, numberOfLines: 1, color: UIColor.white.withAlphaComponent(0.5), alignment: .center)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .clear
        
        let sv = UIStackView(subViews: [dayLabel, dateLabel], axis: .vertical, spacing: 8)
            
        addSubview(sv)
        sv.snp.makeConstraints { (make) in
            make.centerX.top.equalToSuperview()
        }
        
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleCellTapped)))
    }
    
    @objc private func handleCellTapped() {
        guard let calendar = calendar else { return }
        
        checkoutVM.bookingDate = calendar.date
        onDaySelected?(calendar)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
