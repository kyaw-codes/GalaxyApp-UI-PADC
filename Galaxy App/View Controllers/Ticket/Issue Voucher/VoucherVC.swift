//
//  VoucherVC.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 30/05/2021.
//

import UIKit

class VoucherVC: UIViewController {
    
    // MARK: - Properties
    
    var coordinator: TicketCoordinator?
    
    // MARK: - Views
    
    private let closeButton: UIButton = {
        let symbolConfig = UIImage.SymbolConfiguration(font: .systemFont(ofSize: 24, weight: .medium))
        let icon = UIImage(systemName: "xmark", withConfiguration: symbolConfig)?.withRenderingMode(.alwaysOriginal).withTintColor(.galaxyBlack)
        let btn = UIButton(iconImage: icon)
        btn.addTarget(self, action: #selector(handleCloseTapped), for: .touchUpInside)
        return btn
    }()
    
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
   
    private var containerSV: UIStackView?
    
    private let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.alwaysBounceVertical = true
        sv.showsVerticalScrollIndicator = false
        return sv
    }()
    
    // MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        ticketView.ticket = .init(cover: #imageLiteral(resourceName: "showing_1"), movieName: "Detective Pikachu", duration: "105m", format: "IMAX", bookingNo: "GC13532131", showDateTime: "7:00 PM - 10 May", theater: "Galaxy Cinema - Golden City", screen: 2, row: "D", seats: "5, 6", price: 40.00)
        
        setupViews()
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
        
        setupScrollView()
        setupContainerSV()
    }
    
    private func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(closeButton.snp.bottom)
        }
    }
    
    private func setupContainerSV() {
        ticketView.snp.makeConstraints { (make) in
            make.height.equalTo(view.frame.height * 0.76)
        }
        containerSV = UIStackView(subViews: [titleLabel, ticketView], axis: .vertical, spacing: 18)
        
        scrollView.addSubview(containerSV!)
        containerSV?.snp.makeConstraints({ (make) in
            make.leading.trailing.equalToSuperview().inset(34)
            make.top.bottom.centerX.equalToSuperview()
        })
    }
}
