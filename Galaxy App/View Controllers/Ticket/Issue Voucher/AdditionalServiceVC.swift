//
//  AdditionalServiceVC.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 23/05/2021.
//

import UIKit

class AdditionalServiceVC: VerticallyScrollableVC<TicketCoordinator> {
    
    // MARK: - Views
    
    private let backButton = BackButton()
    
    private let promocodeTextField = PromocodeTextField()
    
    private let subTotalLabel = UILabel(text: "Sub total : 40$", font: .poppinsMedium, size: 18, color: .galaxyGreen)
    
    private let payButton = CTAButton(title: "Pay $40.00")
    
    private var comboSetSV: UIStackView?
    private var promocodeSV: UIStackView?
    private var paymentMethodSV: UIStackView?
    
    // MARK: - Lifecycles

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        setupViews()
        
        backButton.addTarget(self, action: #selector(handleBackTapped), for: .touchUpInside)
        payButton.addTarget(self, action: #selector(onPayTap), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        contentStackView.layoutMargins.top = backButton.frame.origin.y
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
        
        setupComboSetSV()
        setupPromocodeSV()
        setupPaymentMethodSV()
        
        [comboSetSV!, promocodeSV!, paymentMethodSV!].forEach { contentStackView.addArrangedSubview($0) }
        contentStackView.spacing = 26
        contentStackView.setCustomSpacing(36, after: comboSetSV!)
    }
    
    private func setupComboSetSV() {
        let comboM = ComboSetView(title: "Combo set M", description: "Combo size M 22oz. Coke (X1) and medium popcorn (X1)", unitPrice: 15)
        let comboL = ComboSetView(title: "Combo set L", description: "Combo size M 32oz. Coke (X1) and large popcorn (X1)", unitPrice: 18)
        let comboFor2 = ComboSetView(title: "Combo for 2", description: "Combo size 2 32oz. Coke (X2) and large popcorn (X1)", unitPrice: 20)
        comboSetSV = UIStackView(subViews: [comboM, comboL, comboFor2], axis: .vertical, spacing: 20)
    }
    
    private func setupPromocodeSV() {
        promocodeTextField.snp.makeConstraints { (make) in
            make.height.equalTo(70)
        }
        promocodeSV = UIStackView(subViews: [promocodeTextField, subTotalLabel], axis: .vertical, spacing: 20)
    }
    
    private func setupPaymentMethodSV() {
        let titleLabel = UILabel(text: "Payment method", font: .poppinsMedium, size: 22, color: .galaxyBlack)
        
        let creditCardPayment = PaymentMethodView(image: #imageLiteral(resourceName: "credit_card"), title: "Credit card", subTitle: "Visa, master card, JCB")
        
        let internetBankingdPayment = PaymentMethodView(image: #imageLiteral(resourceName: "atm_card"), title: "Internet banking(ATM card)", subTitle: "Visa, master card, JCB")
        
        let eWalletPayment = PaymentMethodView(image: #imageLiteral(resourceName: "wallet"), title: "E-Wallet", subTitle: "Paypal")
        
        let sv = UIStackView(subViews: [titleLabel, creditCardPayment, internetBankingdPayment, eWalletPayment], axis: .vertical, spacing: 14)
        sv.setCustomSpacing(20, after: titleLabel)
        
        [sv, payButton].forEach {
            $0.snp.makeConstraints { (make) in
                make.width.equalTo(view.frame.width - 40)
            }
        }

        paymentMethodSV = UIStackView(subViews: [sv, payButton], axis: .vertical, spacing: 30)
        paymentMethodSV?.alignment = .center
    }
}
