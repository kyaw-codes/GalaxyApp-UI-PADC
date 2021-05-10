//
//  MovieDetailVC.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 10/05/2021.
//

import UIKit
import SnapKit

class MovieDetailVC: UIViewController {
    
    var movie: Movie? {
        didSet {
            guard let movie = movie else { return }
            movieImageView.image = UIImage(named: movie.coverImage ?? "")
        }
    }
    
    var movieImageView = UIImageView(image: nil, contentMode: .scaleAspectFill)
    private var playButton: UIButton = {
        let symbolConfig = UIImage.SymbolConfiguration(font: .boldSystemFont(ofSize: 66))
        let iconImage = UIImage(systemName: "play.circle", withConfiguration: symbolConfig)?.withRenderingMode(.alwaysOriginal).withTintColor(.white)
        let button = UIButton(iconImage: iconImage)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        setupView()
    }
    
    private func setupView() {
        view.addSubview(movieImageView)
        movieImageView.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(view.frame.height * 0.46)
        }

        view.addSubview(playButton)
        playButton.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        playButton.snp.makeConstraints { (make) in
            make.centerX.centerY.equalTo(movieImageView)
            make.width.height.equalTo(66)
        }
        playButton.layer.cornerRadius = 66 / 2
    }
}
