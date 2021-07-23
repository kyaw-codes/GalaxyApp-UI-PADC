//
//  AddCreditCardVC.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 23/07/2021.
//

import UIKit

class AddCreditCardVC: UIViewController {
    
    let contentView = UIView(backgroundColor: .white)
    
    var onNewCardAdded: (() -> Void)?
    
    private let cardNoField = OutlineTextField(placeholder: "1234.5678.9101.8014", keyboardType: .numberPad)
    private let cardHolderField = OutlineTextField(placeholder: "Craig Federighi", keyboardType: .default)
    private let expirationDateField = OutlineTextField(placeholder: "08/21", keyboardType: .numbersAndPunctuation)
    private let cvcField = OutlineTextField(placeholder: "150", keyboardType: .numberPad)
    private let confirmButton = CTAButton(title: "Confirm")
    private let spinner = UIActivityIndicatorView(style: .large)

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        view.addSubview(contentView)
        contentView.layer.cornerRadius = 12
        contentView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.centerY.equalToSuperview().inset(-30)
            make.height.equalTo(400)
        }
        
        view.addSubview(spinner)
        spinner.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        
        setupFromSV()
        confirmButton.addTarget(self, action: #selector(onConfirmTapped), for: .touchUpInside)
        confirmButton.layer.shadowColor = nil
        confirmButton.layer.shadowOpacity = 0
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onBackdropTapped))
        view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    private func createFormInput(title: String, textField: UIView) -> UIStackView {
        let titleLabel = UILabel(text: title, font: .poppinsRegular, size: 18, color: .seatReserved)
        return UIStackView(subViews: [titleLabel, textField], axis: .vertical, spacing: 0)
    }
    
    @objc private func onBackdropTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func onConfirmTapped() {
        let cardNo = cardNoField.textField.text ?? ""
        let cardHolder = cardHolderField.textField.text ?? ""
        let expirationDate = expirationDateField.textField.text ?? ""
        let cvc = cvcField.textField.text ?? ""
        spinner.startAnimating()
        
        ApiService.shared.createNewCard(cardNo: cardNo, cardHolder: cardHolder, expirationDate: expirationDate, cvc: cvc) { [weak self] result in
            do {
                let cards = try result.get()
                self?.spinner.stopAnimating()
                self?.onNewCardAdded?()
                self?.dismiss(animated: true, completion: nil)
            } catch {
                fatalError("[Error while creating new card] \(error)")
            }
        }
    }
    
    private func setupFromSV() {
        var inputViews: [UIView] = [("Card number", cardNoField), ("Card holder", cardHolderField)].map { createFormInput(title: $0.0, textField: $0.1) }
        
        let formGroupSV = UIStackView(arrangedSubviews:
                                        [("Expiration date", expirationDateField), ("CVC", cvcField)
                                        ].map { createFormInput(title: $0.0, textField: $0.1) })
        
        formGroupSV.spacing = 20
        formGroupSV.distribution = .fillEqually
        
        inputViews.append(formGroupSV)
        inputViews.append(confirmButton)
        
        let sv = UIStackView(subViews: inputViews, axis: .vertical, spacing: 20)
        sv.setCustomSpacing(30, after: formGroupSV)
        
        contentView.addSubview(sv)
        sv.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview().inset(20)
        }
    }
    
}
