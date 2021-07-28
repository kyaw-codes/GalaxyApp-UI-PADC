//
//  AdditionalServiceVC.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 23/05/2021.
//

import UIKit

class AdditionalServiceVC: UIViewController {
    
    var coordinator: TicketCoordinator?
    
    private var originalPrice: Double = 0.0
    private let checkoutVM = GlobalVoucherModel.instance
    private var selectedSnacks = [SnackData]()
    private var snackList = [Snack]()
    private var paymentMethods = [PaymentMethod]()
    private let dataSource = AdditionalServiceDatasource()
    
    // MARK: - Views
    
    private let backButton = BackButton()
    
    private let promocodeTextField = PromocodeCell()
    
    private let subTotalLabel = UILabel(text: "Sub total : 40$", font: .poppinsMedium, size: 18, color: .galaxyGreen)
    
    private let payButton = CTAButton(title: "Pay $00.00")
    
    private var comboSetSV: UIStackView?
    private var promocodeSV: UIStackView?
    private var paymentMethodSV: UIStackView?
    
    private let collectionView = AdditionalServiceCollectionView()
    private let spinner = UIActivityIndicatorView(style: .large)

    // MARK: - Lifecycles

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        setupViews()
        
        originalPrice = checkoutVM.totalPrice
        payButton.setTitle("Pay $\(originalPrice)", for: .normal)
        
        collectionView.dataSource = dataSource
        dataSource.onSnackTap = { [weak self] snack, qty in
            guard let self = self else { return }
            
            if let index = self.selectedSnacks.firstIndex(where: { $0.id == snack.id }) {
                if qty > 0 {
                    self.selectedSnacks[index].quantity = qty
                } else {
                    self.selectedSnacks.remove(at: index)
                }
            } else {
                self.selectedSnacks.append(SnackData(id: snack.id, quantity: qty))
            }
            
            self.checkoutVM.totalPrice = self.originalPrice + self.calculateSnacksPrice()
            self.checkoutVM.snack = self.selectedSnacks
            self.payButton.setTitle("Pay $\(self.checkoutVM.totalPrice)", for: .normal)
        }
        
        backButton.addTarget(self, action: #selector(handleBackTapped), for: .touchUpInside)
        payButton.addTarget(self, action: #selector(onPayTap), for: .touchUpInside)
        
        fetchSnacks()
        fetchPaymentMethods()
    }
    
    // MARK: - Action Handlers
    
    @objc private func handleBackTapped() {
        coordinator?.popToChooseSeatVC()
    }

    @objc private func onPayTap() {
        coordinator?.checkOut()
    }
    
    // MARK: - Private helpers
    
    private func fetchSnacks() {
        spinner.startAnimating()
        ApiService.shared.fetchSnakcList { [weak self] result in
            do {
                let response = try result.get()
                self?.dataSource.snackList = response.data ?? []
                self?.snackList = response.data ?? []
                self?.collectionView.reloadData()
                self?.spinner.stopAnimating()
            } catch {
                fatalError("[Error while fetching snacks] \(error)")
            }
        }
    }
    
    private func fetchPaymentMethods() {
        spinner.startAnimating()
        ApiService.shared.fetchPayments { [weak self] result in
            do {
                let response = try result.get()
                self?.paymentMethods = response.data ?? []
                self?.dataSource.paymentMethods = self?.paymentMethods ?? []
                self?.collectionView.reloadData()
                self?.spinner.stopAnimating()
            } catch {
                fatalError("[Error while fetching payment methods] \(error)")
            }
        }
    }
    
    private func calculateSnacksPrice() -> Double {
        var total = 0.0
        selectedSnacks.forEach { snackData in
            let snack = self.snackList.first(where: { $0.id == snackData.id })
            total += Double(snack!.price!) * Double(snackData.quantity!)
        }
        return total
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
        
        view.addSubview(spinner)
        spinner.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
}
