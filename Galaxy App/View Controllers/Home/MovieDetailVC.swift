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
    
    var coordinator: HomeCoordinator?
    
    private var movieImageView = UIImageView(image: nil, contentMode: .scaleAspectFill)
    private lazy var movieImageViewHeight = view.frame.height * 0.46
    
    private var playButton: UIButton = {
        let symbolConfig = UIImage.SymbolConfiguration(font: .boldSystemFont(ofSize: 66))
        let iconImage = UIImage(systemName: "play.circle", withConfiguration: symbolConfig)?.withRenderingMode(.alwaysOriginal).withTintColor(.white)
        let button = UIButton(iconImage: iconImage)
        return button
    }()
    
    private lazy var backButton: UIButton = {
        let symbolConfig = UIImage.SymbolConfiguration(font: .systemFont(ofSize: 28, weight: .semibold))
        let icon = UIImage(systemName: "chevron.backward", withConfiguration: symbolConfig)?.withRenderingMode(.alwaysOriginal).withTintColor(.white)
        let btn = UIButton(iconImage: icon)
        btn.addTarget(self, action: #selector(handleBackTapped), for: .touchUpInside)
        return btn
    }()
    
    private let getTicketButton = UIButton(title: "Get your ticket", font: .poppinsSemiBold, textSize: 20, textColor: .white, cornerRadius: 6)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        setupView()
        setupCTAButton()
    }
    
    private func setupView() {
        view.addSubview(movieImageView)
        movieImageView.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(movieImageViewHeight)
        }

        view.addSubview(playButton)
        playButton.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        playButton.snp.makeConstraints { (make) in
            make.centerX.centerY.equalTo(movieImageView)
            make.width.height.equalTo(66)
        }
        playButton.layer.cornerRadius = 66 / 2
        
        view.addSubview(backButton)
        backButton.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.leading.equalToSuperview().inset(20)
        }
    }
    
    private func setupCTAButton() {
        let gradientView = UIView(backgroundColor: .clear)
        view.addSubview(gradientView)
        gradientView.snp.makeConstraints { (make) in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(view.frame.height * 0.25)
        }
        gradientView.applyGradient(colours: [.init(white: 1, alpha: 0.01), .white], locations: [0.2, 0.8], frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height * 0.25))

        view.addSubview(getTicketButton)
        getTicketButton.layer.shadowColor = UIColor.galaxyViolet.cgColor
        getTicketButton.layer.shadowOffset = CGSize(width: 4, height: 5)
        getTicketButton.layer.shadowRadius = 10
        getTicketButton.layer.shadowOpacity = 0.6
        
        getTicketButton.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(30)
            make.height.equalTo(60)
        }
    }
    
    @objc private func handleBackTapped() {
        coordinator?.popToHome()
    }
}
