//
//  TabContentCell.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 05/06/2021.
//

import UIKit

class TabContentCell: UICollectionViewCell {
    
    var viewController: UIViewController? {
        didSet {
            guard let vc = viewController else { return }
            addSubview(vc.view)
            vc.view.snp.makeConstraints { (make) in
                make.leading.trailing.top.bottom.equalToSuperview()
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
