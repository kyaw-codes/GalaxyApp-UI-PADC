//
//  PickTheaterCell.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 09/06/2021.
//

import UIKit

class PickTheaterCell: UICollectionViewCell {
    
    public typealias DataModel = (ChooseTheaterVO, IndexPath)
    
    var indexPath: IndexPath?
    
    var data: DataModel? {
        didSet {
            guard let data = data else { return }
            
            self.indexPath = data.1
            
            let index = data.1.item
            let item = data.0.items[index]
            
            button.setTitle(item.title, for: .normal)
            
            if item.isSelected {
                button.titleColor = .white
                button.backgroundColor = .galaxyViolet
                button.layer.borderWidth = 0
            } else {
                button.titleColor = .galaxyBlack
                button.backgroundColor = .systemBackground
                button.layer.borderWidth = 1
            }
        }
    }
    
    var onButtonSelect: ((IndexPath) -> Void)?
        
    private let button = OutlineButton(title: "")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(button)
        
        button.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
        
        button.addTarget(self, action: #selector(onButtonTapped(_:)), for: .touchUpInside)
    }
    
    @objc private func onButtonTapped(_ sender: UIButton) {
        guard let indexPath = indexPath else { return }
        onButtonSelect!(indexPath)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
