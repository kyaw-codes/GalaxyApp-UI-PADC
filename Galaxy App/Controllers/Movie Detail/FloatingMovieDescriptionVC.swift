//
//  FloatingMovieDescriptionVC.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 11/05/2021.
//

import UIKit
import SnapKit

class FloatingMovieDescriptionVC: VerticallyScrollableVC<HomeCoordinator> {
    
    // MARK: - Properties
    
    var genres = [String]()
    
    var movie: MovieDetail? {
        didSet {
            guard let movie = movie else { return }
            movieTitleLabel.text = movie.originalTitle
            durationLabel.text = calculateDuration(movie.runtime)
            imdbRatingSV.rating = (movie.rating ?? 0) * 0.5
            imdbLabel.text = "IMDb \(movie.rating ?? 0)"
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 3
            
            plotSummaryLabel.attributedText = NSAttributedString(string: movie.overview ?? "", attributes: [NSAttributedString.Key.paragraphStyle : paragraphStyle])
            
            dataSource.casts = movie.casts ?? []
            castCollectionView.snp.makeConstraints { make in
                make.height.equalTo(calculateCastCollectionViewHeight(noOfCasts: movie.casts?.count ?? 0))
            }
            castCollectionView.reloadData()
            
            genres = movie.genres ?? []
            genreDataSource.genres = genres
            genreCollectionView.reloadData()
        }
    }
    
    private var dataSource = CastDatasource()
    private var genreDataSource = GenreDatasource()

    // MARK: - Views
    
    private let movieTitleLabel = UILabel(text: "", font: .poppinsSemiBold, size: 28, numberOfLines: 2, color: .galaxyBlack)
    private let durationLabel = UILabel(text: "", font: .poppinsLight, size: 20, color: .galaxyBlack)
    private let imdbLabel = UILabel(text: "", font: .poppinsLight, size: 20, color: .galaxyBlack)
    
    private let plotTitleLabel = UILabel(text: "Plot Summary", font: .poppinsSemiBold, size: 22, color: .galaxyBlack)
    private let plotSummaryLabel = UILabel(text: "", font: .poppinsLight, size: 18, numberOfLines: 0, color: .galaxyBlack)
    
    private let imdbRatingSV = IMDbRatingSV()
    
    private let castTitleLabel = UILabel(text: "Cast", font: .poppinsSemiBold, size: 22, color: .galaxyBlack)
    
    let castCollectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        cv.backgroundColor = .white
        cv.showsVerticalScrollIndicator = false
        cv.isScrollEnabled = false
        return cv
    }()
    
    let genreCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.showsHorizontalScrollIndicator = false
        cv.backgroundColor = .white
        return cv
    }()
    
    // MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()

        castCollectionView.dataSource = dataSource
        castCollectionView.delegate = self
        
        genreCollectionView.dataSource = genreDataSource
        genreCollectionView.delegate = self

        // Set up parent view
        configureParentView()
        
        setupChildViews()
    }
    
    // MARK: - Private Helpers
    
    private func configureParentView() {
        scrollView.layer.masksToBounds = true
        scrollView.layer.cornerRadius = 28
        scrollView.layer.maskedCorners = CACornerMask(arrayLiteral: [.layerMinXMinYCorner, .layerMaxXMinYCorner])
    }

    private func calculateCastCollectionViewHeight(noOfCasts: Int) -> CGFloat {
        let noOfCols = 4
        let noOfRows: CGFloat = CGFloat(noOfCasts / noOfCols)
        let width = ((view.frame.width - 40 - 20) / 4) - 20
        let height = width + 30 + 20
        return (height * noOfRows) + 100
    }
    
}

// MARK: - Layout Views

extension FloatingMovieDescriptionVC {
    
    private func setupChildViews() {
        
        let subtitleSV = UIStackView(arrangedSubviews: [durationLabel, imdbRatingSV, imdbLabel, UIView()])
        subtitleSV.spacing = 16
        subtitleSV.alignment = .center
        
        let titleSV = UIStackView(subViews: [movieTitleLabel, subtitleSV], axis: .vertical, spacing: 8)
        
        let plotSV = UIStackView(subViews: [plotTitleLabel, plotSummaryLabel], axis: .vertical, spacing: 4)
        view.addSubview(plotSV)
        
        let castSV = UIStackView(subViews: [castTitleLabel, castCollectionView], axis: .vertical, spacing: 12)
        
        genreCollectionView.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        
        [titleSV, genreCollectionView, plotSV, castSV, UIView()].forEach { contentStackView.addArrangedSubview($0) }
        contentStackView.spacing = 22
        contentStackView.layoutMargins.top = 24
        contentStackView.layoutMargins.bottom = 60
    }
}
