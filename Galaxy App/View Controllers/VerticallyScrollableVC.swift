//
//  VerticallyScrollableVC.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 02/06/2021.
//

import UIKit

class VerticallyScrollableVC<T: Coordinator>: UIViewController {
    
    open var coordinator: T?
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.alwaysBounceVertical = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.backgroundColor = .systemBackground
        return scrollView
    }()
    
    let stackView: UIStackView = UIStackView(subViews: [], axis: .vertical, spacing: 20)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
        
        scrollView.addSubview(stackView)
        stackView.snp.makeConstraints { (make) in
            make.leading.trailing.top.bottom.centerX.equalToSuperview()            
        }
    }

}
