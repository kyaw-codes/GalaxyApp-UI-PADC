//
//  FloatingMovieDescriptionVC.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 11/05/2021.
//

import UIKit

class FloatingMovieDescriptionVC: UIViewController {
    
//    init() {
//        super.init(collectionViewLayout: UICollectionViewFlowLayout())
//
//        collectionView.backgroundColor = .clear
//    }
    
//    required init?(coder: NSCoder) {
//        fatalError()
//    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let iv = UIImageView(image: #imageLiteral(resourceName: "showing_3"), contentMode: .scaleAspectFill)
        view.addSubview(iv)
        iv.frame = view.bounds
        
        view.layer.cornerRadius = 30
        view.layer.masksToBounds = true
        view.layer.maskedCorners = CACornerMask(arrayLiteral: [.layerMinXMinYCorner, .layerMaxXMinYCorner])
    }
}
