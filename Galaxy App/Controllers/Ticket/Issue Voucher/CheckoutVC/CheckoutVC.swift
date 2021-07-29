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
    let checkoutVM = GlobalVoucherModel.instance
    
    var cards = [Card]()
    
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
    
    lazy var paymentAmountLabel = UILabel(text: "$ \(checkoutVM.totalPrice)", font: .poppinsSemiBold, size: 32, color: .galaxyBlack)
    
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
        
        fetchCards()
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
    
    private func fetchCards() {
        spinner.startAnimating()
        ApiService.shared.fetchProfile { [weak self] result in
            do {
                let response = try result.get()
                if let cards = response.data?.cards {
                    self?.cards = cards
                    self?.datasource.cards = cards
                    self?.collectionView.reloadData()
                    self?.spinner.stopAnimating()
                    if cards.count > 0 {
                        self?.checkoutVM.cardId = cards[0].id ?? -1
                    }
                }
            } catch {
                fatalError("[Error while fetching profile] \(error)")
            }
        }
    }

    // MARK: - Action Handlers
    
    @objc private func handleBackTapped() {
        coordinator?.popToAdditionalService()
    }
    
    @objc private func handleConfirmTapped() {
        let body = CheckoutData(cinemaDayTimeslotID: checkoutVM.timeslodId, row: "A", seatNumber: checkoutVM.seatNumbers, bookingDate: checkoutVM.bookingDate.getApiDateString(), totalPrice: Int(checkoutVM.totalPrice), movieID: checkoutVM.movieId, cardID: checkoutVM.cardId, cinemaID: checkoutVM.cinemaId, snacks: checkoutVM.snack)
        
        ApiService.shared.checkout(body) { [weak self] result in
            do {
                let response = try result.get()
                self?.checkoutVM.bookingNo = response.data?.bookingNo ?? ""
                self?.checkoutVM.startTime = response.data?.timeslot?.startTime ?? ""
                self?.checkoutVM.row = response.data?.row ?? ""
                
                self?.coordinator?.issueVoucher()
            } catch {
                fatalError("[Error while issuing voucher] \(error)")
            }
        }
    }
    
    @objc private func handleAddNewCardTapped() {
        let formVC = AddCreditCardVC()
        formVC.modalTransitionStyle = .crossDissolve
        formVC.modalPresentationStyle = .overCurrentContext
        formVC.onNewCardAdded = { [weak self] in
            self?.fetchCards()
        }
        self.navigationController?.present(formVC, animated: true, completion: nil)
    }
}
