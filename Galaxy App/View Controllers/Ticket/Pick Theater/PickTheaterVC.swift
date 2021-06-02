//
//  PickTheaterVC.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 21/05/2021.
//

import UIKit

class PickTheaterVC: UIViewController {
    
    // MARK: - Properties

    var coordinator: TicketCoordinator?
    
    private let calendarDatasource = CalendarDatasource()

    // MARK: - Views
    
    private let backButton = BackButton(iconColor: .white)
    
    private let calendarCollectionView = CalendarCollectionView()
    
    private let pickerView = ContentView()
    
    // MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .galaxyViolet

        setupChildViews()
        
        calendarCollectionView.delegate = self
        calendarCollectionView.dataSource = calendarDatasource
        
        pickerView.handleNextTap = { [weak self] in
            self?.coordinator?.chooseSeat()
        }
        
        backButton.addTarget(self, action: #selector(handleBackTapped), for: .touchUpInside)
    }
    
    // MARK: - Action Handler

    @objc private func handleBackTapped() {
        coordinator?.popToMovieDetail()
    }
}

// MARK: - Layout Views

extension PickTheaterVC {
    
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
}
