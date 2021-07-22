//
//  ChooseSeatVC.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 22/05/2021.
//

import UIKit

class ChooseSeatVC: VerticallyScrollableVC<TicketCoordinator> {
    
    // MARK: - Properties
    
    private let datasource = SeatingPlanDatasource()

    // MARK: - Views
    
    private let backButton = BackButton()
    
    private let checkoutVM = CheckoutVM.instance
    
    private lazy var movieLabel = UILabel(text: checkoutVM.movieName, font: .poppinsSemiBold, size: 26, numberOfLines: 2, color: .galaxyBlack, alignment: .center)
    private lazy var cinemaLabel = UILabel(text: checkoutVM.cinemaName, font: .poppinsRegular, size: 18, numberOfLines: 1, color: .galaxyLightBlack, alignment: .center)
    private lazy var dateTimeLabel = UILabel(text: "\(checkoutVM.bookingDateString), \(checkoutVM.bookingTime)", font: .poppinsRegular, size: 18, numberOfLines: 1, color: .galaxyBlack, alignment: .center)

    private let seatCollectionView = SeatingPlanCollectionView()
    
    private let buyTicketButton = CTAButton(title: "Buy Ticket for $00.00")
    
    private var topSV: UIStackView?
    private var middleSV: UIStackView?
    private var bottomSV: UIStackView?
    
    // MARK: - Lifecycles

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        
        seatCollectionView.delegate = self
        seatCollectionView.dataSource = datasource
        
        setupViews()

        backButton.addTarget(self, action: #selector(handleBackTapped), for: .touchUpInside)
        buyTicketButton.addTarget(self, action: #selector(handleBuyTapped), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        contentStackView.layoutMargins.top = backButton.frame.origin.y
        
        let height = seatCollectionView.contentSize.height
        if height > 0 {
            seatCollectionView.snp.makeConstraints { (make) in
                make.height.equalTo(seatCollectionView.contentSize.height)
            }
        }
    }
    
    // MARK: - Private Helpers
    
    private func createSeatsLabel(_ texts: String...) -> [UILabel] {
        texts.map {
            UILabel(text: $0, font: .poppinsRegular, size: 18, color: .galaxyLightBlack, alignment: .center)
        }
    }
    
    private func createSeatLegend(title: String, color: UIColor) -> UIStackView {
        let circle = UIView(backgroundColor: color)

        circle.snp.makeConstraints { (make) in
            make.width.height.equalTo(20)
        }
        circle.layer.cornerRadius = 20 / 2
        let label = UILabel(text: title, font: .poppinsLight, size: 14, color: .galaxyBlack)
        
        let sv = UIStackView(arrangedSubviews: [circle, label])
        sv.spacing = 8
        return sv
    }
    
    // MARK: - Action Handlers
    
    @objc private func handleBackTapped() {
        coordinator?.popToPickTheater()
    }
    
    @objc private func handleBuyTapped() {
        coordinator?.pickAdditionalService()
    }
    
}

// MARK: - Layout Views

extension ChooseSeatVC {
    
    private func setupViews() {
        view.addSubview(backButton)
        backButton.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(18)
            make.leading.equalToSuperview().inset(24)
        }
        
        setupTopSV()
        setupMiddleSV()
        setupBottomSV()
        
        [topSV!, middleSV!, bottomSV!, UIView()].forEach { contentStackView.addArrangedSubview($0) }
        
        contentStackView.setCustomSpacing(80, after: topSV!)
    }
    
    private func setupTopSV() {
        let projectorView = ProjectorView(frame: CGRect(x: -10, y: 0, width: view.frame.width - 20, height: 36))
        
        topSV = UIStackView(subViews: [movieLabel, cinemaLabel, dateTimeLabel, projectorView], axis: .vertical, spacing: 0)
        topSV?.setCustomSpacing(6, after: cinemaLabel)
        topSV?.setCustomSpacing(20, after: dateTimeLabel)
    }
    
    private func setupMiddleSV() {
        let leadingSV = UIStackView(subViews: createSeatsLabel("A", "B", "C", "D", "E", "F", "G"), axis: .vertical, spacing: 0)
        let trailingSV = UIStackView(subViews: createSeatsLabel("A", "B", "C", "D", "E", "F", "G"), axis: .vertical, spacing: 0)
        [leadingSV, trailingSV].forEach {
            $0.distribution = .fillEqually
            $0.isLayoutMarginsRelativeArrangement = true
            $0.layoutMargins = UIEdgeInsets(top: 2, left: 0, bottom: 0, right: 0)
        }

        let seatingPlanSV = UIStackView(arrangedSubviews: [leadingSV, seatCollectionView, trailingSV])
        seatingPlanSV.spacing = 10
        
        let availableSeatLegend = createSeatLegend(title: "Available", color: .seatAvailable)
        let reservedSeatLegend = createSeatLegend(title: "Reserved", color: .seatReserved)
        let selectionSeatLegend = createSeatLegend(title: "Your selection", color: .galaxyViolet)
        
        let legendSV = UIStackView(arrangedSubviews: [availableSeatLegend, reservedSeatLegend, selectionSeatLegend])
        legendSV.distribution = .fillEqually
        legendSV.isLayoutMarginsRelativeArrangement = true
        legendSV.layoutMargins = UIEdgeInsets(top: 0, left: 4, bottom: 0, right: 4)
        
        let dashLine = DashLine(color: .seatAvailable)
        dashLine.snp.makeConstraints { (make) in
            make.height.equalTo(2)
        }
        
        middleSV = UIStackView(subViews: [seatingPlanSV, legendSV, dashLine], axis: .vertical, spacing: 20)
        middleSV?.setCustomSpacing(28, after: legendSV)
        
        middleSV?.isLayoutMarginsRelativeArrangement = true
    }
    
    private func setupBottomSV() {
        let ticketLabel = UILabel(text: "Tickets", font: .poppinsRegular, size: 20, color: .galaxyLightBlack)
        let noOfTicketLabel = UILabel(text: "2", font: .poppinsRegular, size: 20, color: .galaxyBlack, alignment: .right)
        
        let seatsLabel = UILabel(text: "Seats", font: .poppinsRegular, size: 20, color: .galaxyLightBlack)
        let seatsNoLabel = UILabel(text: "D Row/5, 6", font: .poppinsRegular, size: 20, color: .galaxyBlack, alignment: .right)
        
        [ticketLabel, seatsLabel].forEach { $0.snp.makeConstraints { (make) in
            make.width.equalTo(view.frame.width * 0.65)
        } }
        
        let ticketSV = UIStackView(arrangedSubviews: [ticketLabel, noOfTicketLabel])
        let seatSV = UIStackView(arrangedSubviews: [seatsLabel, seatsNoLabel])
        
        let sv = UIStackView(subViews: [ticketSV, seatSV], axis: .vertical, spacing: 16)
        
        buyTicketButton.snp.makeConstraints { (make) in
            make.width.equalTo(view.frame.width - 40)
        }
        bottomSV = UIStackView(subViews: [sv, buyTicketButton], axis: .vertical, spacing: 28)
        bottomSV?.alignment = .center
    }
}

extension ChooseSeatVC: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        
        if let selectedItems = collectionView.indexPathsForSelectedItems {
            if selectedItems.contains(indexPath) {
                collectionView.deselectItem(at: indexPath, animated: true)
                return false
            }
        }
        return true
    }

}
