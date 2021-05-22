//
//  ChooseSeatVC.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 22/05/2021.
//

import UIKit

class ChooseSeatVC: UIViewController {
    
    var coordinator: TicketCoordinator?
    
    private let backButton: UIButton = {
        let symbolConfig = UIImage.SymbolConfiguration(font: .systemFont(ofSize: 28, weight: .medium))
        let icon = UIImage(systemName: "chevron.backward", withConfiguration: symbolConfig)?.withRenderingMode(.alwaysOriginal).withTintColor(.galaxyBlack)
        let btn = UIButton(iconImage: icon)
        btn.addTarget(self, action: #selector(handleBackTapped), for: .touchUpInside)
        return btn
    }()
    
    private var topSV: UIStackView?
    private var middleSV: UIStackView?
    private var bottomSV: UIStackView?
    private var containerSV: UIStackView?
    
    private let movieLabel = UILabel(text: "Detective Pikachu", font: .poppinsSemiBold, size: 26, numberOfLines: 2, color: .galaxyBlack, alignment: .center)
    private let cinemaLabel = UILabel(text: "Galaxy Cinema - Golden City", font: .poppinsRegular, size: 18, numberOfLines: 1, color: .galaxyLightBlack, alignment: .center)
    private let dateTimeLabel = UILabel(text: "Wednesday, 10 May, 07:00 PM", font: .poppinsRegular, size: 18, numberOfLines: 1, color: .galaxyBlack, alignment: .center)

    private let scrollView = UIScrollView()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        setupViews()
        scrollView.alwaysBounceVertical = true
        scrollView.showsVerticalScrollIndicator = false
    }
    
    private func setupViews() {
        view.addSubview(backButton)
        backButton.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(18)
            make.leading.equalToSuperview().inset(20)
        }
        
        setupTopSV()
        
        containerSV = UIStackView(subViews: [topSV!, UIView()], axis: .vertical, spacing: 20)
        
        scrollView.addSubview(containerSV!)
        containerSV?.snp.makeConstraints({ (make) in
            make.leading.trailing.top.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
        })
        
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalTo(backButton.snp.bottom)
            make.bottom.equalToSuperview()
        }
    }
    
    private func setupTopSV() {
        topSV = UIStackView(subViews: [movieLabel, cinemaLabel, dateTimeLabel], axis: .vertical, spacing: 0)
        topSV?.setCustomSpacing(6, after: cinemaLabel)
    }
    
    @objc private func handleBackTapped() {
        coordinator?.popToPickTheater()
    }
    
}
