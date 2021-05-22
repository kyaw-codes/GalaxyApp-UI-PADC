//
//  PickTheaterVC.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 21/05/2021.
//

import UIKit

class PickTheaterVC: UIViewController {
    
    var coordinator: TicketCoordinator?
    
    private let backButton: UIButton = {
        let symbolConfig = UIImage.SymbolConfiguration(font: .systemFont(ofSize: 28, weight: .medium))
        let icon = UIImage(systemName: "chevron.backward", withConfiguration: symbolConfig)?.withRenderingMode(.alwaysOriginal).withTintColor(.white)
        let btn = UIButton(iconImage: icon)
        btn.addTarget(self, action: #selector(handleBackTapped), for: .touchUpInside)
        return btn
    }()
    
    private let calendarCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.showsHorizontalScrollIndicator = false
        cv.alwaysBounceHorizontal = true
        cv.backgroundColor = .clear
        return cv
    }()
    
    private let pickerView = PickerView()
    
    private let calendarDatasource = CalendarDatasource()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .galaxyViolet

        setupChildViews()
        calendarCollectionView.delegate = self
        calendarCollectionView.dataSource = calendarDatasource
        
        pickerView.handleNextTap = { [weak self] in
            self?.coordinator?.chooseSeat()
        }
    }
    
    private func setupChildViews() {
        view.addSubview(backButton)
        backButton.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(18)
            make.leading.equalToSuperview().inset(20)
        }
        
        view.addSubview(pickerView)
        pickerView.snp.makeConstraints { (make) in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalToSuperview().inset(view.frame.height * 0.22)
        }
        
        view.addSubview(calendarCollectionView)
        calendarCollectionView.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(backButton.snp.bottom).inset(-18)
            make.bottom.equalTo(pickerView.snp.top).inset(-18)
        }
    }

    @objc private func handleBackTapped() {
        coordinator?.popToMovieDetail()
    }
}
