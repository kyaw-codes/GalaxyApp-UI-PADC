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
    private let checkoutVM = CheckoutVM.instance
    
    private var cards = [Card]()
    
    // MARK: - Views
    
    private let backButton = BackButton()
    
    private let addNewCardButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("  Add new card", for: .normal)
        btn.setTitleColor(.galaxyGreen, for: .normal)
        btn.titleLabel?.font = UIFont.GalaxyFont.poppinsMedium.font(of: 18)
        
        let iconConfig = UIImage.SymbolConfiguration(font: .systemFont(ofSize: 22))
        let addIcon = UIImage(systemName: "plus.circle.fill", withConfiguration: iconConfig)?.withRenderingMode(.alwaysOriginal).withTintColor(.galaxyGreen)
        btn.setImage(addIcon, for: .normal)
        
        return btn
    }()
    
    private let confirmButton = CTAButton(title: "Confirm")
    
    private lazy var paymentAmountLabel = UILabel(text: "$ \(checkoutVM.totalPrice)", font: .poppinsSemiBold, size: 32, color: .galaxyBlack)
    
    private let cardNoField = OutlineTextField(placeholder: "1234.5678.9101.8014", keyboardType: .numberPad)
    private let cardHolderField = OutlineTextField(placeholder: "Craig Federighi", keyboardType: .default)
    private let expirationDateField = OutlineTextField(placeholder: "08/21", keyboardType: .numbersAndPunctuation)
    private let cvcField = OutlineTextField(placeholder: "150", keyboardType: .numberPad)
    
    private var headerSV: UIStackView?
    private var cardCollectionSV: UIStackView?
    private var formSV: UIStackView?
    private let spinner = UIActivityIndicatorView(style: .large)
    
    private let collectionView: GeminiCollectionView = {
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
        coordinator?.issueVoucher()
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

// MARK: - Layout Views

extension CheckoutVC {
    
    private func setupViews() {
        view.addSubview(backButton)
        backButton.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(18)
            make.leading.equalToSuperview().inset(24)
        }
        
        view.addSubview(spinner)
        spinner.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        
        setupHeaderSV()
        setupCardCollectionSV()
        setupFromSV()
        
        [headerSV!, cardCollectionSV!, formSV!].forEach { contentStackView.addArrangedSubview($0) }
        contentStackView.setCustomSpacing(36, after: cardCollectionSV!)
    }
    
    private func setupHeaderSV() {
        let subTitle = UILabel(text: "Payment amount", font: .poppinsRegular, size: 16, color: .seatReserved)
        headerSV = UIStackView(subViews: [subTitle, paymentAmountLabel], axis: .vertical, spacing: 8)
        headerSV?.isLayoutMarginsRelativeArrangement = true
        headerSV?.layoutMargins = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
    }
    
    private func setupCardCollectionSV() {
        collectionView.snp.makeConstraints { (make) in
            make.height.equalTo(200)
        }
        
        cardCollectionSV = UIStackView(arrangedSubviews: [collectionView])
    }
    
    private func setupFromSV() {
        let addNewCardSV = UIStackView(arrangedSubviews: [addNewCardButton, UIView()])
        formSV = UIStackView(subViews: [addNewCardSV, confirmButton], axis: .vertical, spacing: 26)
        
        formSV?.isLayoutMarginsRelativeArrangement = true
        formSV?.layoutMargins = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        formSV?.setCustomSpacing(30, after: addNewCardSV)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension CheckoutVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width * 0.8, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        collectionView.animateVisibleCells()
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cell = cell as? GeminiCell {
            self.collectionView.animateCell(cell)
        }
    }
}
