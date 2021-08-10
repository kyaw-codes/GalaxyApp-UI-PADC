//
//  CheckoutVC.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 27/05/2021.
//

import UIKit
import Gemini
import SnapKit

class CheckoutVC: VerticallyScrollableVC<TicketCoordinator> {
    
    // MARK: - Properties
    
    private let datasource = CreditCardDatasource()
    let voucherModel = GlobalVoucherModel.instance
    
    var cards = [Card]() {
        didSet {
            datasource.cards = cards
        }
    }
    
    // MARK: - Views
    
    let backButton = BackButton()
    
    let addNewCardButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("  Add new card", for: .normal)
        btn.setTitleColor(.galaxyGreen, for: .normal)
        btn.titleLabel?.font = UIFont.GalaxyFont.poppinsMedium.font(of: 18)
        
        let iconConfig = UIImage.SymbolConfiguration(font: .systemFont(ofSize: 22))
        let addIcon = UIImage(systemName: "plus.circle.fill", withConfiguration: iconConfig)?.withRenderingMode(.alwaysOriginal).withTintColor(.galaxyGreen)
        btn.setImage(addIcon, for: .normal)
        
        return btn
    }()
    
    let confirmButton = CTAButton(title: "Confirm")
    
    lazy var paymentAmountLabel = UILabel(text: "$ \(voucherModel.totalPrice)", font: .poppinsSemiBold, size: 32, color: .galaxyBlack)
    
    let cardNoField = OutlineTextField(placeholder: "1234.5678.9101.8014", keyboardType: .numberPad)
    let cardHolderField = OutlineTextField(placeholder: "Craig Federighi", keyboardType: .default)
    let expirationDateField = OutlineTextField(placeholder: "08/21", keyboardType: .numbersAndPunctuation)
    let cvcField = OutlineTextField(placeholder: "150", keyboardType: .numberPad)
    
    var headerSV: UIStackView?
    var cardCollectionSV: UIStackView?
    var formSV: UIStackView?
    let spinner = UIActivityIndicatorView(style: .large)
    
    let collectionView: GeminiCollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = GeminiCollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.showsHorizontalScrollIndicator = false
        return cv
    }()
    
    // MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white 
        setupViews()
        
        collectionView.dataSource = datasource
        collectionView.delegate = self
        configureCollectionViewScrollingAnimation()

        backButton.addTarget(self, action: #selector(handleBackTapped), for: .touchUpInside)
        confirmButton.addTarget(self, action: #selector(handleConfirmTapped), for: .touchUpInside)
        addNewCardButton.addTarget(self, action: #selector(handleAddNewCardTapped), for: .touchUpInside)
        
        fetchCards(then: setter(for: self, keyPath: \.cards))
    }
    
    override func viewDidLayoutSubviews() {
        contentStackView.layoutMargins = UIEdgeInsets(top: backButton.frame.origin.y, left: 0, bottom: 0, right: 0)
    }
    
    // MARK: - Private Helpers
    
    private func configureCollectionViewScrollingAnimation() {
        collectionView.gemini
            .customAnimation()
            .scale(x: 0.9, y: 0.7, z: 0.8)
            .shadowEffect(.nextFadeIn)
            .alpha(0.3)
            .ease(.easeInOutCirc)
    }
    
    private func fetchCards(then completion: @escaping ([Card]) -> Void) {
        spinner.startAnimating()
        NetworkAgentImpl.shared.fetchProfile { [weak self] result in
            do {
                let response = try result.get()
                if let cards = response.data?.cards {
                    completion(cards)
                    self?.collectionView.reloadData()
                    self?.spinner.stopAnimating()

                    if cards.count > 0 {
                        self?.voucherModel.cardId = cards[0].id ?? -1
                    }
                }
            } catch {
                print("[Error while fetching profile] \(error)")
            }
        }
    }

    // MARK: - Action Handlers
    
    @objc private func handleBackTapped() {
        coordinator?.popToAdditionalService()
    }
    
    @objc private func handleConfirmTapped() {
        let reqBody = CheckoutData(
            cinemaDayTimeslotID: voucherModel.timeslodId,
            row: "A",
            seatNumber: voucherModel.seatNumbers,
            bookingDate: voucherModel.bookingDate.getApiDateString(),
            totalPrice: Int(voucherModel.totalPrice),
            movieID: voucherModel.movieId,
            cardID: voucherModel.cardId,
            cinemaID: voucherModel.cinemaId,
            snacks: voucherModel.snack
        )
        
        NetworkAgentImpl.shared.checkout(reqBody) { [weak self] result in
            do {
                let response = try result.get()
                self?.voucherModel.bookingNo = response.data?.bookingNo ?? ""
                self?.voucherModel.startTime = response.data?.timeslot?.startTime ?? ""
                self?.voucherModel.row = response.data?.row ?? ""
                
                self?.coordinator?.issueVoucher()
            } catch {
                print("[Error while issuing voucher] \(error)")
            }
        }
    }
    
    @objc private func handleAddNewCardTapped() {
        let formVC = AddCreditCardVC()
        formVC.modalTransitionStyle = .crossDissolve
        formVC.modalPresentationStyle = .overCurrentContext
        
        formVC.onNewCardAdded = { [weak self] in
            guard let self = self else { return }
            self.fetchCards(then: self.setter(for: self, keyPath: \.cards))
        }
        self.navigationController?.present(formVC, animated: true, completion: nil)
    }
}
