//
//  MovieCell.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 09/05/2021.
//

import UIKit
import SnapKit

class MovieCell: UICollectionViewCell {
    
    var movie: Movie? {
        didSet {
            guard let movie = movie else { return }
            imageView.image = UIImage(named: movie.coverImage ?? "")
            titleLabel.text = movie.name
            subtitleLabel.text = "\(movie.primaryGenre!)/\(movie.secondaryGenre!) . \(movie.duration!)"
        }
    }
    
    private let shadowView: UIView = {
        let view = UIView(backgroundColor: .black)
        view.layer.shadowColor = UIColor.galaxyViolet.cgColor
        view.layer.shadowOpacity = 0.3
        view.layer.shadowOffset = CGSize(width: 5, height: 8)
        view.layer.shadowRadius = 10
        view.layer.cornerRadius = 12
        return view
    }()
    
    private let imageView: UIImageView = {
        let iv = UIImageView(image: #imageLiteral(resourceName: "showing_1"), contentMode: .scaleAspectFill)
        iv.layer.cornerRadius = 12
        iv.clipsToBounds = true
        return iv
    }()
    
    private var titleLabel = UILabel(text: "", font: .poppinsSemiBold, size: 13, numberOfLines: 1, color: .galaxyBlack, alignment: .center)
    private var subtitleLabel = UILabel(text: "", font: .poppinsRegular, size: 10, numberOfLines: 1, color: .galaxyLightBlack, alignment: .center)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let imageViewHeight = frame.width + 70
        
        addSubview(shadowView)
        
        shadowView.snp.makeConstraints { (make) in
            make.leading.top.trailing.equalToSuperview()
            make.height.equalTo(imageViewHeight)
        }
        
        imageView.snp.makeConstraints { (make) in
            make.height.equalTo(imageViewHeight).priority(.high)
        }
        
        let sv = UIStackView(subViews: [imageView, titleLabel, subtitleLabel], axis: .vertical, spacing: 4)
        sv.setCustomSpacing(20, after: imageView)
        
        addSubview(sv)
        sv.snp.makeConstraints { (make) in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
