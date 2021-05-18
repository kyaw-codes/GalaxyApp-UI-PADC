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
        view.addSubview(movieTitleLabel)
        movieTitleLabel.snp.makeConstraints { (make) in
            make.leading.top.equalToSuperview().inset(24)
        }
        
        view.addSubview(durationLabel)
        durationLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(movieTitleLabel)
            make.top.equalTo(movieTitleLabel.snp.bottom).inset(-8)
        }
        
        view.addSubview(imdbRatingSV)
        imdbRatingSV.snp.makeConstraints { (make) in
            make.leading.equalTo(durationLabel.snp.trailing).inset(-20)
            make.top.bottom.equalTo(durationLabel)
        }
        
        view.addSubview(imdbLabel)
        imdbLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(imdbRatingSV.snp.trailing).inset(-20)
            make.top.equalTo(durationLabel)
        }
    }
}
