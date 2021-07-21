//
//  FloatingMovieDescriptionVC+CollectionViewDelegate.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 20/05/2021.
//

import UIKit

extension FloatingMovieDescriptionVC : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == castCollectionView {
            let width = ((view.frame.width - 40 - 20) / 4) - 20
            let height = width + 30
            return CGSize(width: width, height: height)
        } else {
            let width = genres[indexPath.row].size(withAttributes: [NSAttributedString.Key.font : UIFont.GalaxyFont.poppinsLight.font(of: 16)]).width
            return CGSize(width: width + 50, height: collectionView.frame.height)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 18
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return collectionView == castCollectionView ? 20 : 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return collectionView == castCollectionView ? UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10) : .zero
    }
    
}
