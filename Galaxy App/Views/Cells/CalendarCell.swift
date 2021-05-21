//
//  CalendarCell.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 21/05/2021.
//

import UIKit

class CalendarCell: UICollectionViewCell {
    
    var calendar: Calendar? {
        didSet {
            guard let calendar = calendar else { return }
            dayLabel.text = calendar.day
            dateLabel.text = calendar.date
            
            if calendar.isToday {
                dayLabel.textColor = .white
                dayLabel.font = UIFont.GalaxyFont.poppinsMedium.font(of: 20)
                
                dateLabel.textColor = .white
                dateLabel.font = UIFont.GalaxyFont.poppinsMedium.font(of: 26)
            }
        }
    }
    
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
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
