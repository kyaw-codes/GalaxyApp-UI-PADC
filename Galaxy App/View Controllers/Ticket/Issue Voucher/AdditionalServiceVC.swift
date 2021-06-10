//
//  AdditionalServiceVC.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 23/05/2021.
//

import UIKit

class AdditionalServiceVC: UIViewController {
    
    var coordinator: TicketCoordinator?
    
    // MARK: - Views
    
    private let backButton = BackButton()
    
    private let promocodeTextField = PromocodeCell()
    
    private let subTotalLabel = UILabel(text: "Sub total : 40$", font: .poppinsMedium, size: 18, color: .galaxyGreen)
    
    private let payButton = CTAButton(title: "Pay $40.00")
    
    private var comboSetSV: UIStackView?
    private var promocodeSV: UIStackView?
    private var paymentMethodSV: UIStackView?
    
    private let collectionView = AdditionalServiceCollectionView()
    private let dataSource = AdditionalServiceDatasource()
    
    // MARK: - Lifecycles

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        setupViews()
        
        collectionView.dataSource = dataSource
        
        backButton.addTarget(self, action: #selector(handleBackTapped), for: .touchUpInside)
        payButton.addTarget(self, action: #selector(onPayTap), for: .touchUpInside)
    }
    
    // MARK: - Action Handlers
    
    @objc private func handleBackTapped() {
        coordinator?.popToChooseSeatVC()
    }

    @objc private func onPayTap() {
        coordinator?.checkOut()
    }
}

// MARK: - Layout Views

extension AdditionalServiceVC {
    
    private func setupViews() {
        view.addSubview(backButton)
        backButton.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(18)
            make.leading.equalToSuperview().inset(24)
        }
        
        view.addSubview(collectionView)
        view.addSubview(payButton)

        collectionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(backButton.snp.bottom).inset(-10)
            make.bottom.equalTo(payButton.snp.top)
        }
        
        payButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }
}
