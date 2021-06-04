//
//  VoucherVC.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 30/05/2021.
//

import UIKit

class VoucherVC: VerticallyScrollableVC<TicketCoordinator> {
    
    // MARK: - Views
    
    private let closeButton = CloseButton()
    
    private let titleLabel: UILabel = {
        let lbl = UILabel(text: "", font: .poppinsMedium, size: 28, numberOfLines: 2, color: .galaxyBlack, alignment: .center)

        let attrString = NSMutableAttributedString(string: "Awesome!")
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 3
        paragraphStyle.alignment = .center
        
        let subtitleAttrs = [NSAttributedString.Key.foregroundColor : UIColor.seatReserved,
                             NSAttributedString.Key.font : UIFont.GalaxyFont.poppinsLight.font(of: 18),
                             NSAttributedString.Key.paragraphStyle : paragraphStyle
        ]
        attrString.append(NSAttributedString(string: "\nThis is your ticket.", attributes: subtitleAttrs))
        
        lbl.attributedText = attrString
        return lbl
    }()
    
    private let ticketView = TicketView()
   
    // MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        ticketView.ticket = .init(cover: #imageLiteral(resourceName: "showing_1"), movieName: "Detective Pikachu", duration: "105m", format: "IMAX", bookingNo: "GC13532131", showDateTime: "7:00 PM - 10 May", theater: "Galaxy Cinema - Golden City", screen: 2, row: "D", seats: "5, 6", price: 40.00)
        
        setupViews()
        
        closeButton.addTarget(self, action: #selector(handleCloseTapped), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        contentStackView.layoutMargins.top = closeButton.frame.height + 10
    }
    
    // MARK: - Action Handlers
    
    @objc private func handleCloseTapped() {
        coordinator?.closeVoucherSlip()
    }
}

// MARK: - Layout Views

extension VoucherVC {
    
    private func setupViews() {
        view.addSubview(closeButton)
        
        closeButton.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(18)
            make.leading.equalToSuperview().inset(24)
        }
        
        ticketView.snp.makeConstraints { (make) in
            make.height.equalTo(view.frame.height * 0.76)
        }
        
        [titleLabel, ticketView].forEach { contentStackView.addArrangedSubview($0) }
        contentStackView.spacing = 18
    }
}
