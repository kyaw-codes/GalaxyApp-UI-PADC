//
//  MovieDetailVC.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 10/05/2021.
//

import UIKit
import FloatingPanel

class MovieDetailVC: UIViewController, FloatingPanelControllerDelegate {
    
    // MARK: - Properties
    
    var movieId: Int = -1
    
    var movie: MovieDetail? {
        didSet {
            guard let movie = movie else { return }
            movieImageView.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/original\(movie.posterPath ?? "")"))
            descriptionVC.movie = movie
        }
    }
    
    var coordinator: HomeCoordinator?
    
    // MARK: - Views
    
    let descriptionVC = FloatingMovieDescriptionVC()

    var movieImageView = UIImageView(image: nil, contentMode: .scaleAspectFill)
    lazy var movieImageViewHeight = view.frame.height * 0.46
    
    var playButton: UIButton = {
        let symbolConfig = UIImage.SymbolConfiguration(font: .boldSystemFont(ofSize: 66))
        let iconImage = UIImage(systemName: "play.circle", withConfiguration: symbolConfig)?.withRenderingMode(.alwaysOriginal).withTintColor(.white)
        let button = UIButton(iconImage: iconImage)
        return button
    }()
    
    let backButton = BackButton(iconColor: .white)
    
    let getTicketButton = CTAButton(title: "Get your ticket")
    let spinner = UIActivityIndicatorView(style: .large)
    
    // MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        setupView()
        setupFloatingMovieDescriptionVC()
        setupCTAButton()
        
        backButton.addTarget(self, action: #selector(handleBackTapped), for: .touchUpInside)
        getTicketButton.addTarget(self, action: #selector(handleGetTicketTapped), for: .touchUpInside)
        
        fetchMovieDetail(then: setter(for: self, keyPath: \.movie))
    }
    
    // MARK: - Action Handlers
    
    @objc private func handleBackTapped() {
        coordinator?.popToHome()
    }
    
    @objc private func handleGetTicketTapped() {
        coordinator?.getTicket()
    }
    
    // MARK: - Private Helpers
    
    private func fetchMovieDetail(then completion: @escaping (MovieDetail?) -> Void) {
        spinner.startAnimating()
        ApiService.shared.getMovieDetail(movieId) { [weak self] result in
            do {
                let response = try result.get()
                completion(response.data)
                self?.spinner.stopAnimating()

                GlobalVoucherModel.instance.apply { model in
                    model.movieName = response.data?.originalTitle ?? ""
                    model.movieId = response.data?.id ?? -1
                    model.duration = "\(response.data?.runtime ?? 0)m"
                    model.imageUrl = response.data?.posterPath ?? ""
                }
            } catch {
                fatalError("[Error while fetching movie detail] \(error)")
            }
        }
    }
}
