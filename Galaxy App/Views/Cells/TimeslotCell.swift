//
//  PickTheaterCell.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 09/06/2021.
//

import UIKit

class TimeslotCell: UICollectionViewCell {
    
    var onMovieTypeSelected: ((MovieTypeVM) -> Void)?
    var onCinemaTimeSlotSelected: ((Int, Int) -> Void)?
    
    var indexPath: IndexPath?
    
    var movieType: MovieTypeVM? {
        didSet {
            guard let movieType = movieType else { return }
            
            button.setTitle(movieType.title, for: .normal)
            if movieType.isSelected {
                button.titleColor = .white
                button.backgroundColor = .galaxyViolet
                button.layer.borderWidth = 0
            } else {
                button.titleColor = .galaxyBlack
                button.backgroundColor = .systemBackground
                button.layer.borderWidth = 1
            }
        }
    }
    
    var cinema: CinemaTimeSlotVM? {
        didSet {
            guard let cinema = cinema else { return }
            guard let indexPath = indexPath else { fatalError("Set indexpath first") }
            
            button.setTitle(cinema.timeslots[indexPath.item].startTime, for: .normal)
            
            if cinema.timeslots[indexPath.item].isSelected {
                button.titleColor = .white
                button.backgroundColor = .galaxyViolet
                button.layer.borderWidth = 0
            } else {
                button.titleColor = .galaxyBlack
                button.backgroundColor = .systemBackground
                button.layer.borderWidth = 1
            }
        }
    }
            
    private let button = OutlineButton(title: "")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(button)
        
        button.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
        
        button.addTarget(self, action: #selector(onButtonTapped(_:)), for: .touchUpInside)
    }
    
    @objc private func onButtonTapped(_ sender: UIButton) {
        if movieType != nil {
            // Movie type cell
            onMovieTypeSelected?(movieType!)
        } else {
            // Time slot
            guard let indexPath = indexPath else { return }
            let timeslotId = cinema!.timeslots[indexPath.item].cinemaDayTimeslotID ?? -1
            let cinemaId = cinema!.cinemaID ?? -1
            
            let checkoutVM = CheckoutVM.instance
            checkoutVM.cinemaName = cinema!.cinema ?? ""
            checkoutVM.bookingTime = cinema!.timeslots[indexPath.item].startTime ?? ""
            
            onCinemaTimeSlotSelected?(cinemaId, timeslotId)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
