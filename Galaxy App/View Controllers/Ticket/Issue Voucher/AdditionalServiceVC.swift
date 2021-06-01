//
//  AdditionalServiceVC.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 23/05/2021.
//

import UIKit

class AdditionalServiceVC: UIViewController {
    
    // MARK: - Properties
    
    var coordinator: TicketCoordinator?
    
    // MARK: - Views
    
    private let backButton: UIButton = {
        let symbolConfig = UIImage.SymbolConfiguration(font: .systemFont(ofSize: 28, weight: .medium))
        let icon = UIImage(systemName: "chevron.backward", withConfiguration: symbolConfig)?.withRenderingMode(.alwaysOriginal).withTintColor(.galaxyBlack)
        let btn = UIButton(iconImage: icon)
        btn.addTarget(self, action: #selector(handleBackTapped), for: .touchUpInside)
        return btn
    }()
    
    private let promocodeTextField = PromocodeTextField()
    
    private let subTotalLabel = UILabel(text: "Sub total : 40$", font: .poppinsMedium, size: 18, color: .galaxyGreen)
    
    private let payButton = UIButton(title: "Pay $40.00", font: .poppinsMedium, textSize: 18, textColor: .white, backgroundColor: .galaxyViolet) { (btn) in
        
        btn.layer.shadowColor = UIColor.galaxyViolet.cgColor
        btn.layer.shadowOffset = CGSize(width: 4, height: 5)
        btn.layer.shadowRadius = 10
        btn.layer.shadowOpacity = 0.6
        
        btn.snp.makeConstraints { (make) in
            make.height.equalTo(60)
        }
    }
    
    private let scrollView = UIScrollView()
    
    private var parentContainerSV: UIStackView?
    private var comboSetSV: UIStackView?
    private var promocodeSV: UIStackView?
    private var paymentMethodSV: UIStackView?
    
    // MARK: - Lifecycles

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        setupViews()
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
        
        setupScrollView()
        
        setupComboSetSV()
        setupPromocodeSV()
        setupPaymentMethodSV()
        
        setupParentContainerView()
    }
    
    private func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.top.equalTo(backButton.snp.bottom).inset(-20)
            make.leading.trailing.bottom.equalToSuperview()
        }
        scrollView.alwaysBounceVertical = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.keyboardDismissMode = .onDrag
    }
    
    private func setupParentContainerView() {
        
        parentContainerSV = UIStackView(subViews: [comboSetSV!, promocodeSV!, paymentMethodSV!], axis: .vertical, spacing: 26)
        parentContainerSV?.setCustomSpacing(36, after: comboSetSV!)
        
        scrollView.addSubview(parentContainerSV!)
        parentContainerSV?.snp.makeConstraints({ (make) in
            make.leading.trailing.top.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
        })
    }
    
    private func setupComboSetSV() {
        let comboM = ComboSetView(title: "Combo set M", description: "Combo size M 22oz. Coke (X1) and medium popcorn (X1)", unitPrice: 15)
        let comboL = ComboSetView(title: "Combo set L", description: "Combo size M 32oz. Coke (X1) and large popcorn (X1)", unitPrice: 18)
        let comboFor2 = ComboSetView(title: "Combo for 2", description: "Combo size 2 32oz. Coke (X2) and large popcorn (X1)", unitPrice: 20)
        comboSetSV = UIStackView(subViews: [comboM, comboL, comboFor2], axis: .vertical, spacing: 20)
        comboSetSV?.isLayoutMarginsRelativeArrangement = true
        comboSetSV?.layoutMargins = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
    
    private func setupPromocodeSV() {
        promocodeTextField.snp.makeConstraints { (make) in
            make.height.equalTo(70)
        }
        promocodeSV = UIStackView(subViews: [promocodeTextField, subTotalLabel], axis: .vertical, spacing: 20)
        promocodeSV?.isLayoutMarginsRelativeArrangement = true
        promocodeSV?.layoutMargins = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
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
