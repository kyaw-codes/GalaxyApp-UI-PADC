//
//  AdditionalServiceVC.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 23/05/2021.
//

import UIKit

class AdditionalServiceVC: UIViewController {
    
    var coordinator: TicketCoordinator?
    
    private var priceBeforeThisVC: Double = 0.0
    private let checkoutVM = GlobalVoucherModel.instance
    private var selectedSnacks = [SnackData]()
    
    private var snackList = [Snack]() {
        didSet {
            dataSource.snackList = snackList
        }
    }
    
    private var paymentMethods = [PaymentMethod]() {
        didSet {
            dataSource.paymentMethods = paymentMethods
        }
    }
    
    private let dataSource = AdditionalServiceDatasource()
    
    // MARK: - Views
    
    let backButton = BackButton()
    let promocodeTextField = PromocodeCell()
    let subTotalLabel = UILabel(text: "Sub total : 40$", font: .poppinsMedium, size: 18, color: .galaxyGreen)
    let payButton = CTAButton(title: "Pay $00.00")
    var comboSetSV: UIStackView?
    var promocodeSV: UIStackView?
    var paymentMethodSV: UIStackView?
    let collectionView = AdditionalServiceCollectionView()
    let spinner = UIActivityIndicatorView(style: .large)

    // MARK: - Lifecycles
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        priceBeforeThisVC = checkoutVM.totalPrice
        payButton.setTitle("Pay $\(priceBeforeThisVC)", for: .normal)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        setupViews()
        
        collectionView.dataSource = dataSource
        dataSource.onSnackTap = onSnackTap(snack:qty:)
        
        backButton.addTarget(self, action: #selector(handleBackTapped), for: .touchUpInside)
        payButton.addTarget(self, action: #selector(onPayTap), for: .touchUpInside)
        
        fetchSnacks(then: setter(for: self, keyPath: \.snackList))
        fetchPaymentMethods(then: setter(for: self, keyPath: \.paymentMethods))
    }
    
    // MARK: - Action Handlers
    
    @objc private func handleBackTapped() {
        coordinator?.popToChooseSeatVC()
    }

    @objc private func onPayTap() {
        coordinator?.checkOut()
    }
    
    // MARK: - Private helpers
    
    private func fetchSnacks(then: @escaping ([Snack]) -> Void) {
        spinner.startAnimating()
        NetworkAgentImpl.shared.fetchSnakcList { [weak self] result in
            do {
                let response = try result.get()
                then(response.data ?? [])
                self?.collectionView.reloadData()
                self?.spinner.stopAnimating()
            } catch {
                fatalError("[Error while fetching snacks] \(error)")
            }
        }
    }
    
    private func fetchPaymentMethods(then: @escaping ([PaymentMethod]) -> Void) {
        spinner.startAnimating()
        NetworkAgentImpl.shared.fetchPayments { [weak self] result in
            do {
                let response = try result.get()
                then(response.data ?? [])
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
    
    private func onSnackTap(snack: Snack, qty: Int) {
        if let index = selectedSnacks.firstIndex(where: { $0.id == snack.id }) {
            if qty > 0 {
                selectedSnacks[index].quantity = qty
            } else {
                selectedSnacks.remove(at: index)
            }
        } else {
            selectedSnacks.append(SnackData(id: snack.id, quantity: qty))
        }
        
        checkoutVM.totalPrice = priceBeforeThisVC + calculateSnacksPrice()
        checkoutVM.snack = selectedSnacks
        payButton.setTitle("Pay $\(checkoutVM.totalPrice)", for: .normal)
    }
}
