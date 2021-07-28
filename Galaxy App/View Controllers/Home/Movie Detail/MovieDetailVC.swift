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
    
    private let descriptionVC = FloatingMovieDescriptionVC()

    private var movieImageView = UIImageView(image: nil, contentMode: .scaleAspectFill)
    private lazy var movieImageViewHeight = view.frame.height * 0.46
    
    private var playButton: UIButton = {
        let symbolConfig = UIImage.SymbolConfiguration(font: .boldSystemFont(ofSize: 66))
        let iconImage = UIImage(systemName: "play.circle", withConfiguration: symbolConfig)?.withRenderingMode(.alwaysOriginal).withTintColor(.white)
        let button = UIButton(iconImage: iconImage)
        return button
    }()
    
    private let backButton = BackButton(iconColor: .white)
    
    private let getTicketButton = CTAButton(title: "Get your ticket")
    private let spinner = UIActivityIndicatorView(style: .large)
    
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
                GlobalVoucherModel.instance.collectData(of: self, keypath: \.movie)
                self?.spinner.stopAnimating()
            } catch {
                fatalError("[Error while fetching movie detail] \(error)")
            }
        }
    }
}

// MARK: - Layout Views

extension MovieDetailVC {
    
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
            make.top.equalTo(view.safeAreaLayoutGuide).inset(18)
            make.leading.equalToSuperview().inset(20)
        }
        
        view.addSubview(spinner)
        spinner.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
    
    private func setupFloatingMovieDescriptionVC() {
        let fpc = FloatingPanelController(delegate: self)
        fpc.surfaceView.backgroundColor = .clear
        fpc.backdropView.backgroundColor = .white

        fpc.layout = Layout()
        
        fpc.set(contentViewController: descriptionVC)
        fpc.contentMode = .static
        fpc.surfaceView.grabberHandleSize = .zero
        fpc.track(scrollView: descriptionVC.scrollView)

        fpc.addPanel(toParent: self)
        view.bringSubviewToFront(spinner)
    }
    
    private func setupCTAButton() {
        let gradientView = UIView(backgroundColor: .clear)
        view.addSubview(gradientView)
        gradientView.isUserInteractionEnabled = false
        gradientView.snp.makeConstraints { (make) in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(view.frame.height * 0.25)
        }
        gradientView.applyGradient(colours: [.init(white: 1, alpha: 0.15), .white], locations: [0.2, 0.7], frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height * 0.25))

        view.addSubview(getTicketButton)
        getTicketButton.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(30)
        }
    }
}
