//
//  ChooseSeatVC.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 22/05/2021.
//

import UIKit

class ChooseSeatVC: UIViewController {
    
    // MARK: - Properties
    
    var coordinator: TicketCoordinator?
    
    private let datasource = SeatingPlanDatasource()

    // MARK: - Views
    
    private let backButton: UIButton = {
        let symbolConfig = UIImage.SymbolConfiguration(font: .systemFont(ofSize: 28, weight: .medium))
        let icon = UIImage(systemName: "chevron.backward", withConfiguration: symbolConfig)?.withRenderingMode(.alwaysOriginal).withTintColor(.galaxyBlack)
        let btn = UIButton(iconImage: icon)
        btn.addTarget(self, action: #selector(handleBackTapped), for: .touchUpInside)
        return btn
    }()
    
    private let movieLabel = UILabel(text: "Detective Pikachu", font: .poppinsSemiBold, size: 26, numberOfLines: 2, color: .galaxyBlack, alignment: .center)
    private let cinemaLabel = UILabel(text: "Galaxy Cinema - Golden City", font: .poppinsRegular, size: 18, numberOfLines: 1, color: .galaxyLightBlack, alignment: .center)
    private let dateTimeLabel = UILabel(text: "Wednesday, 10 May, 07:00 PM", font: .poppinsRegular, size: 18, numberOfLines: 1, color: .galaxyBlack, alignment: .center)

    private let seatCollectionView = SeatingPlanCollectionView()
    
    private let buyTicketButton = UIButton(title: "Buy Ticket for $20.00", font: .poppinsMedium, textSize: 18, textColor: .white, backgroundColor: .galaxyViolet) { (btn) in
        
        btn.layer.shadowColor = UIColor.galaxyViolet.cgColor
        btn.layer.shadowOffset = CGSize(width: 4, height: 5)
        btn.layer.shadowRadius = 10
        btn.layer.shadowOpacity = 0.6
        
        btn.snp.makeConstraints { (make) in
            make.height.equalTo(60)
        }
    }
    
    private var topSV: UIStackView?
    private var middleSV: UIStackView?
    private var bottomSV: UIStackView?
    private var containerSV: UIStackView?

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.alwaysBounceVertical = true
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    // MARK: - Lifecycles

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        
        seatCollectionView.dataSource = datasource
        
        buyTicketButton.addTarget(self, action: #selector(handleBuyTapped), for: .touchUpInside)
        
        setupViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
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
        setupContainerSV()
        setupScrollView()

    }
    
    private func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(backButton.snp.bottom)
        }
    }
    
    private func setupContainerSV() {
        containerSV = UIStackView(subViews: [topSV!, middleSV!, bottomSV!, UIView()], axis: .vertical, spacing: 20)
        containerSV?.setCustomSpacing(80, after: topSV!)

        scrollView.addSubview(containerSV!)
        containerSV?.snp.makeConstraints({ (make) in
            make.leading.trailing.top.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
        })

    }
    
    private func setupTopSV() {
        let projectorView = ProjectorView(frame: CGRect(x: 0, y: 0, width: view.frame.width - 40, height: 30))
        
        topSV = UIStackView(subViews: [movieLabel, cinemaLabel, dateTimeLabel, projectorView], axis: .vertical, spacing: 0)
        topSV?.setCustomSpacing(6, after: cinemaLabel)
        topSV?.setCustomSpacing(20, after: dateTimeLabel)
        
        topSV?.isLayoutMarginsRelativeArrangement = true
        topSV?.layoutMargins = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
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
        middleSV?.layoutMargins = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
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
