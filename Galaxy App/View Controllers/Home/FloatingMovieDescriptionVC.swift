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
            
            primaryGenreBadgeView = createGenreBadge(name: movie.primaryGenre)
            secondaryGenreBadgeView = createGenreBadge(name: movie.secondaryGenre)
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 3
            
            plotSummaryLabel.attributedText = NSAttributedString(string: movie.plot ?? "", attributes: [NSAttributedString.Key.paragraphStyle : paragraphStyle])
            
            dataSource = CastDatasource(casts: movie.casts)
        }
    }
    
    private let movieTitleLabel = UILabel(text: "Detective Pikachu", font: .poppinsSemiBold, size: 28, numberOfLines: 2, color: .galaxyBlack)
    private let durationLabel = UILabel(text: "1h 45m", font: .poppinsLight, size: 20, color: .galaxyBlack)
    private let imdbLabel = UILabel(text: "1h 45m", font: .poppinsLight, size: 20, color: .galaxyBlack)
    private var primaryGenreBadgeView: UIView?
    private var secondaryGenreBadgeView: UIView?
    
    private let plotTitleLabel = UILabel(text: "Plot Summary", font: .poppinsSemiBold, size: 22, color: .galaxyBlack)
    private let plotSummaryLabel = UILabel(text: "", font: .poppinsLight, size: 18, numberOfLines: 0, color: .galaxyBlack)
    
    private let imdbRatingSV = IMDbRatingSV()
    
    private let castTitleLabel = UILabel(text: "Cast", font: .poppinsSemiBold, size: 22, color: .galaxyBlack)
    
    private lazy var castCollectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        cv.dataSource = dataSource
        cv.delegate = self
        cv.backgroundColor = .white
        return cv
    }()
    
    private var dataSource: CastDatasource?

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
        
        let genreSV = UIStackView()
        if let primaryGenreBadgeView = primaryGenreBadgeView, let secondaryGenreBadgeView = secondaryGenreBadgeView  {
            genreSV.addArrangedSubview(primaryGenreBadgeView)
            genreSV.addArrangedSubview(secondaryGenreBadgeView)
            genreSV.addArrangedSubview(UIView())
            
            genreSV.spacing = 20
        }
        
        view.addSubview(genreSV)
        genreSV.snp.makeConstraints { (make) in
            make.leading.trailing.equalTo(titleSV)
            make.top.equalTo(titleSV.snp.bottom).inset(-14)
        }
        
        let plotSV = UIStackView(subViews: [plotTitleLabel, plotSummaryLabel], axis: .vertical, spacing: 4)
        view.addSubview(plotSV)
        plotSV.snp.makeConstraints { (make) in
            make.leading.trailing.equalTo(genreSV)
            make.top.equalTo(genreSV.snp.bottom).inset(-15)
        }
        
        view.addSubview(castTitleLabel)
        castTitleLabel.snp.makeConstraints { (make) in
            make.leading.trailing.equalTo(plotSV)
            make.top.equalTo(plotSV.snp.bottom).inset(-15)
        }
        
        view.addSubview(castCollectionView)
        castCollectionView.snp.makeConstraints { (make) in
            make.leading.trailing.equalTo(castTitleLabel)
            make.top.equalTo(castTitleLabel.snp.bottom).inset(-15)
            make.bottom.equalToSuperview()
        }
        
    }

    private func createGenreBadge(name genreName: String?) -> UIView? {
        guard let genreName = genreName else { return nil }
        let label = UILabel(text: genreName, font: .poppinsLight, size: 16, color: .galaxyBlack)
        let width: CGFloat = genreName.size(withAttributes: [NSAttributedString.Key.font : UIFont.GalaxyFont.poppinsLight.font(of: 16)]).width
        let height: CGFloat = 44
        let padding: CGFloat = 50
        let genreView = UIView()
        genreView.addSubview(label)
        
        label.snp.makeConstraints { (make) in
            make.centerX.centerY.equalToSuperview()
        }
        
        genreView.snp.makeConstraints { (make) in
            make.width.equalTo(width + padding)
            make.height.equalTo(height)
        }
        genreView.layer.cornerRadius = height / 2
        genreView.clipsToBounds = true
        genreView.layer.borderWidth = 0.5
        genreView.layer.borderColor = UIColor.galaxyLightBlack.cgColor
        return genreView
    }
    
}
