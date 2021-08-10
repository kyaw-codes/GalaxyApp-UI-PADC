//
//  ChooseSeatVC.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 22/05/2021.
//

import UIKit

class ChooseSeatVC: VerticallyScrollableVC<TicketCoordinator> {
    
    // MARK: - Properties
    
    private let datasource = SeatingPlanDatasource()
    
    private var seats = [[Seat]]() {
        didSet {
            datasource.seats = seats
        }
    }
    
    private var selectedSeats = [String]()
    private var ticketPrice: Double = 0.0
    private var priceBeforeThisVC: Double = 0.0

    // MARK: - Views
    
    let backButton = BackButton()
    
    let checkoutVM = GlobalVoucherModel.instance
    
    lazy var movieLabel = UILabel(text: checkoutVM.movieName, font: .poppinsSemiBold, size: 26, numberOfLines: 2, color: .galaxyBlack, alignment: .center)
    lazy var cinemaLabel = UILabel(text: checkoutVM.cinemaName, font: .poppinsRegular, size: 18, numberOfLines: 1, color: .galaxyLightBlack, alignment: .center)
    lazy var dateTimeLabel = UILabel(text: "\(checkoutVM.bookingDateString), \(checkoutVM.bookingTime)", font: .poppinsRegular, size: 18, numberOfLines: 1, color: .galaxyBlack, alignment: .center)

    let seatCollectionView = SeatingPlanCollectionView()
    
    let buyTicketButton = CTAButton(title: "Buy Ticket for $00.00")
    let noOfTicketLabel = UILabel(text: "0", font: .poppinsRegular, size: 20, color: .galaxyBlack, alignment: .right)
    let seatsNoLabel: UILabel = {
        let lbl = UILabel(text: "-", font: .poppinsRegular, size: 20, color: .galaxyBlack, alignment: .right)
        lbl.numberOfLines = 2
        return lbl
    }()

    var topSV: UIStackView?
    var middleSV: UIStackView?
    var bottomSV: UIStackView?
    let spinner = UIActivityIndicatorView(style: .large)
    
    // MARK: - Lifecycles
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        priceBeforeThisVC = checkoutVM.totalPrice
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        
        seatCollectionView.delegate = self
        seatCollectionView.dataSource = datasource
        datasource.onSeatTapped = onSeatTapped

        setupViews()
        fetchSeatData(then: setter(for: self, keyPath: \.seats))

        backButton.addTarget(self, action: #selector(handleBackTapped), for: .touchUpInside)
        buyTicketButton.addTarget(self, action: #selector(handleBuyTapped), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        contentStackView.layoutMargins.top = backButton.frame.origin.y
        
        let height = seatCollectionView.contentSize.height
        if height > 0 {
            seatCollectionView.snp.makeConstraints { (make) in
                make.height.equalTo(seatCollectionView.contentSize.height)
            }
        }
    }
    
    // MARK: - Private Helpers
    
    private func fetchSeatData(then completion: @escaping ([[Seat]]) -> Void) {
        let checkoutVM = GlobalVoucherModel.instance
        spinner.startAnimating()
        NetworkAgentImpl.shared.fetchSeatPlan(timeslodId: checkoutVM.timeslodId, date: checkoutVM.bookingDate) { [weak self] result in
            do {
                let response = try result.get()
                completion(response.data ?? [[]])
                self?.seatCollectionView.reloadData()
                self?.spinner.stopAnimating()
            } catch {
                fatalError("[Error while fetching seat plan] \(error)")
            }
        }
    }
    
    private func onSeatTapped() {
        let indexPaths = seatCollectionView.indexPathsForSelectedItems!
        
        selectedSeats = []
        ticketPrice = 0.0
        
        indexPaths.forEach { ip in
            let seat: Seat = seats[ip.section][ip.item]
            selectedSeats.append(seat.seatName ?? "")
            ticketPrice += Double(seat.price ?? 0)
        }
        
        noOfTicketLabel.text = "\(indexPaths.count)"
        seatsNoLabel.text = selectedSeats.joined(separator: ",")
        buyTicketButton.setTitle("Buy Ticket for $\(ticketPrice)", for: .normal)
        checkoutVM.seatNumbers = selectedSeats.joined(separator: ",")
        checkoutVM.totalPrice = priceBeforeThisVC + ticketPrice
    }
    
    // MARK: - Action Handlers
    
    @objc private func handleBackTapped() {
        coordinator?.popToPickTheater()
    }
    
    @objc private func handleBuyTapped() {
        coordinator?.pickAdditionalService()
    }
    
}

// MARK: - UICollectionViewDelegate
extension ChooseSeatVC: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        if let selectedItems = collectionView.indexPathsForSelectedItems {
            if selectedItems.contains(indexPath) {
                collectionView.deselectItem(at: indexPath, animated: true)
                return false
            }
        }
        return true
    }
}
