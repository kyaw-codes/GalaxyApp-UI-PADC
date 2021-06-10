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
    
    private var chooseTheaterVOs: [ChooseTheaterVO] = [
        .init(title: "Available in", items: [.init(title: "2D", isSelected: true), .init(title: "3D"), .init(title: "IMAX")]),
        .init(title: "GC: Golden City", items: [.init(title: "9:30 AM", isSelected: true), .init(title: "11:45 AM"), .init(title: "3:30 PM"), .init(title: "5:00 PM"), .init(title: "7:00 PM"), .init(title: "9:30 PM")]),
        .init(title: "GC: West Point", items: [.init(title: "9:30 AM"), .init(title: "11:45 AM"), .init(title: "3:30 PM"), .init(title: "5:00 PM"), .init(title: "7:00 PM"), .init(title: "9:30 PM")]),
    ]
    
    private let calendarDatasource = CalendarDatasource()
    
    private lazy var pickTheaterDatasource: PickTheaterDatasource = PickTheaterDatasource(data: chooseTheaterVOs)
    
    // MARK: - Views
    
    private let backButton = BackButton(iconColor: .white)
    
    private let calendarCollectionView = CalendarCollectionView()
    private let pickTheaterCollectionView = PickTheaterCollectionView()
    
    private let nextButton = CTAButton(title: "Next")
    
    // MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .galaxyViolet

        setupViews()
        
        calendarCollectionView.dataSource = calendarDatasource
        pickTheaterCollectionView.dataSource = pickTheaterDatasource
        
        pickTheaterDatasource.onButtonSelect = { [weak self] indexPath in
            guard let self = self else { return }
            
            if indexPath.section == 0 {
                self.resetAvailableMovieTypes(at: indexPath.item)
            } else {
                self.resetAvailableTimes(at: indexPath)
            }
            
            self.pickTheaterCollectionView.reloadData()
        }
        
        backButton.addTarget(self, action: #selector(handleBackTapped), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(handleNextTapped), for: .touchUpInside)
    }
    
    // MARK: - Private Helper
    
    private func resetAvailableMovieTypes(at index: Int) {
        for (i, item) in chooseTheaterVOs[0].items.enumerated() {
            if i == index {
                item.isSelected = true
            } else {
                item.isSelected = false
            }
        }
    }
    
    private func resetAvailableTimes(at indexPath: IndexPath) {
        for sectionIndex in 1..<chooseTheaterVOs.count {
            let section = chooseTheaterVOs[sectionIndex]
            let items = section.items
            
            if sectionIndex == indexPath.section {
                // Select an item from this section
                for (itemIndex, item) in items.enumerated() {
                    item.isSelected = itemIndex == indexPath.item
                }
            } else {
                // This section is not selected so unselect all
                items.forEach { $0.isSelected = false }
            }
        }
    }

    // MARK: - Action Handler

    @objc private func handleBackTapped() {
        coordinator?.popToMovieDetail()
    }

    @objc private func handleNextTapped() {
        coordinator?.chooseSeat()
    }

}

// MARK: - Layout Views

extension PickTheaterVC {
    
    private func setupViews() {
        let backgroundView = UIView(backgroundColor: .white)
        view.addSubview(backgroundView)
        backgroundView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.6)
        }

        view.addSubview(backButton)
        backButton.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(18)
            make.leading.equalToSuperview().inset(20)
        }
        
        view.addSubview(calendarCollectionView)
        calendarCollectionView.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(backButton.snp.bottom).inset(-18)
            make.height.equalTo(80)
        }
        
        view.addSubview(pickTheaterCollectionView)
        view.addSubview(nextButton)

        pickTheaterCollectionView.snp.makeConstraints { make in
            make.top.equalTo(calendarCollectionView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(nextButton.snp.top)
        }
        
        nextButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }
}
