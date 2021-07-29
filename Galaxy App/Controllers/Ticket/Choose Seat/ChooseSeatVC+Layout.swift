//
//  ChooseSeatVC+Layout.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 28/07/2021.
//

import UIKit

extension ChooseSeatVC {
    
    func setupViews() {
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
        
        view.addSubview(spinner)
        spinner.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
    
    private func setupTopSV() {
        let projectorView = ProjectorView(frame: CGRect(x: -10, y: 0, width: view.frame.width - 20, height: 36))
        
        topSV = UIStackView(subViews: [movieLabel, cinemaLabel, dateTimeLabel, projectorView], axis: .vertical, spacing: 0)
        topSV?.setCustomSpacing(6, after: cinemaLabel)
        topSV?.setCustomSpacing(20, after: dateTimeLabel)
    }
    
    private func setupMiddleSV() {
        
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
        
        seatCollectionView.snp.makeConstraints { make in
            make.height.equalTo(600)
        }
        
        middleSV = UIStackView(subViews: [seatCollectionView, legendSV, dashLine], axis: .vertical, spacing: 20)
        middleSV?.setCustomSpacing(28, after: legendSV)
        
        middleSV?.isLayoutMarginsRelativeArrangement = true
    }
    
    private func setupBottomSV() {
        let ticketLabel = UILabel(text: "Tickets", font: .poppinsRegular, size: 20, color: .galaxyLightBlack)

        let seatsLabel = UILabel(text: "Seats", font: .poppinsRegular, size: 20, color: .galaxyLightBlack)
        
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
}
