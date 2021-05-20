//
//  FloatingMovieDescriptionVC.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 11/05/2021.
//

import UIKit

class FloatingMovieDescriptionVC: UIViewController {
    
    var movie: Movie? {
        didSet {
            guard let movie = movie else { return }
            movieTitleLabel.text = movie.name
            durationLabel.text = movie.duration
            imdbRatingSV.rating = movie.imbdRating
            imdbLabel.text = "IMDb \(movie.imbdRating!)"
        }
    }
    
    private let movieTitleLabel = UILabel(text: "Detective Pikachu", font: .poppinsSemiBold, size: 28, numberOfLines: 2, color: .galaxyBlack)
    private let durationLabel = UILabel(text: "1h 45m", font: .poppinsLight, size: 20, color: .galaxyBlack)
    private let imdbLabel = UILabel(text: "1h 45m", font: .poppinsLight, size: 20, color: .galaxyBlack)
    
    private let imdbRatingSV = IMDbRatingSV()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Set up parent view
        configureParentView()
        setupChildViews()
    }
    
    private func configureParentView() {
        view.backgroundColor = .white
        view.layer.cornerRadius = 30
        view.layer.masksToBounds = true
        view.layer.maskedCorners = CACornerMask(arrayLiteral: [.layerMinXMinYCorner, .layerMaxXMinYCorner])
    }
    
    private func setupChildViews() {
        let subtitleSV = UIStackView(arrangedSubviews: [durationLabel, imdbRatingSV, imdbLabel, UIView()])
        subtitleSV.spacing = 16
        subtitleSV.alignment = .center
        
        let titleSV = UIStackView(subViews: [movieTitleLabel, subtitleSV], axis: .vertical, spacing: 8)
        
        view.addSubview(titleSV)
        titleSV.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalToSuperview().inset(24)
        }
    }

    
    
}
