//
//  Rating.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 18/05/2021.
//

import UIKit

class IMDbRatingSV: UIStackView {
    
    var numberOfStars: Int = 5 {
        didSet {
            setupStars()
        }
    }
    
    var rating: Double! = 5 {
        didSet {
            setupStars()
        }
    }
    
    private var maxRating: Double = 10
    
    var starSize: CGFloat = 18 {
        didSet {
            setupStars()
        }
    }
    
    init() {
        super.init(frame: .zero)
        
        setupStars()
        
        self.alignment = .center
        self.spacing = 6
    }

    private func setupStars() {
        removeArrangedSubViews()
                
        let symbolConfig = UIImage.SymbolConfiguration(font: .systemFont(ofSize: starSize))
        
        let starImage = UIImage(systemName: "star.fill", withConfiguration: symbolConfig)?
            .withRenderingMode(.alwaysTemplate)
        
        for index in 0..<numberOfStars {
            let iv = UIImageView(image: starImage)
            
            let calculatedRating = round(rating * (Double(numberOfStars) / maxRating))
            
            if index < Int(calculatedRating) {
                iv.tintColor = .systemYellow
            } else {
                iv.tintColor = .init(white: 0.8, alpha: 1)
            }
            
            addArrangedSubview(iv)
        }
    }
    
    private func removeArrangedSubViews() {
        let removedSubviews = arrangedSubviews.reduce([]) { (allSubviews, subview) -> [UIView] in
                    self.removeArrangedSubview(subview)
                    return allSubviews + [subview]
                }
                
        // Remove the views from self
        removedSubviews.forEach({ $0.removeFromSuperview() })
    }
    
    required init(coder: NSCoder) {
        fatalError()
    }
}
