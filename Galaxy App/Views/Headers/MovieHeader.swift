//
//  MovieHeader.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 09/05/2021.
//

import UIKit
import SnapKit

class MovieHeader: UICollectionReusableView {
    
    static let kind = String(describing: MovieHeader.self)
    
    var headerText: String? {
        didSet {
            label.text = headerText
        }
    }
    
    private let label = UILabel(text: "", font: .poppinsSemiBold, size: 20, color: .galaxyBlack)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(label)
        label.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
