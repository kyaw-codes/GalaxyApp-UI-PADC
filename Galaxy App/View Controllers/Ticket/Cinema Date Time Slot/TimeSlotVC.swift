//
//  TimeSlotVC.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 21/05/2021.
//

import UIKit

class TimeSlotVC: UIViewController {
    
    // MARK: - Properties

    var coordinator: TicketCoordinator?
    
    private let calendarDatasource = CalendarDatasource()
    private let timeslotDatasource = TimeSlotDatasource()
    
    private let dates = generateDates()
    private let movieTypes: [MovieTypeVM] = [.init(title: "2D", isSelected: true), .init(title: "3D"), .init(title: "IMAX")]
    private var timeslots = [CinemaTimeSlotVM]()
    
    // MARK: - Views
    
    private let backButton = BackButton(iconColor: .white)
    
    private let calendarCollectionView = CalendarCollectionView()
    
    private let nextButton = CTAButton(title: "Next")
    
    private let scrollView = UIScrollView(backgroundColor: .white)
    private let movieTypesCollectionView = MovieTypeCollectionView()
    private let timeSlotsCollectionView = TimeSlotCollectionView()
    
    // MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .galaxyViolet

        setupViews()
        
        scrollView.layer.cornerRadius = 30
        scrollView.layer.masksToBounds = true
        scrollView.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMinYCorner)
        scrollView.showsVerticalScrollIndicator = false
        
        calendarDatasource.dates = dates
        calendarDatasource.onDaySelected = { [weak self] vm in
            self?.dates.forEach { $0.isSelected = $0.date == vm.date }
            self?.calendarCollectionView.reloadData()
            self?.fetchTimeSlots(date: vm.date.getApiDateString())
        }
        calendarCollectionView.dataSource = calendarDatasource
        
        movieTypesCollectionView.types = movieTypes
        movieTypesCollectionView.onMovieTypeSelected = { vm in
            self.movieTypes.forEach { $0.isSelected = vm.title == $0.title }
            self.movieTypesCollectionView.reloadData()
        }
        
        timeslotDatasource.onCinemaTimeSlotSelected = { [weak self] _, timeslotId in
            CheckoutVM.instance.timeslodId = timeslotId
            self?.timeslots.forEach{ cinema in
                cinema.timeslots.forEach { timeslot in
                    if timeslot.cinemaDayTimeslotID == timeslotId {
                        timeslot.isSelected = true
                    } else {
                        timeslot.isSelected = false
                    }
                }
            }
            
            self?.timeSlotsCollectionView.reloadData()
        }
        
        timeSlotsCollectionView.dataSource = timeslotDatasource
        fetchTimeSlots(date: Date().getApiDateString())
        
        backButton.addTarget(self, action: #selector(handleBackTapped), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(handleNextTapped), for: .touchUpInside)
    }
    
    // MARK: - Private Helper
    
    private func fetchTimeSlots(date: String) {
        ApiService.shared.fetchCinemaDayTimeSlots(movieId: CheckoutVM.instance.movieId, date: date) { [weak self] result in
            do {
                let response = try result.get()
                let cinemas = response.getCinemaVM() ?? []
                cinemas[0].timeslots[0].isSelected = true
                CheckoutVM.instance.cinemaName = cinemas[0].cinema ?? ""
                CheckoutVM.instance.bookingTime = cinemas[0].timeslots[0].startTime ?? ""
                CheckoutVM.instance.timeslodId = cinemas[0].timeslots[0].cinemaDayTimeslotID ?? -1
                
                self?.timeslots = cinemas
                self?.timeslotDatasource.cinemas = cinemas
                self?.timeSlotsCollectionView.reloadData()
            } catch {
                fatalError("[Error while fetching cinema day time slots] \(error)")
            }
        }
    }

    // MARK: - Action Handler

    @objc private func handleBackTapped() {
        coordinator?.popToMovieDetail()
    }

    @objc private func handleNextTapped() {
        coordinator?.chooseSeat()
    }

}

// MARK: - Layout Views

extension TimeSlotVC {
    
    private func setupViews() {
        let backgroundView = UIView(backgroundColor: .white)
        view.addSubview(backgroundView)
        backgroundView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.6)
        }

        view.addSubview(backButton)
        backButton.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(18)
            make.leading.equalToSuperview().inset(20)
        }
        
        view.addSubview(calendarCollectionView)
        calendarCollectionView.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(backButton.snp.bottom).inset(-18)
            make.height.equalTo(80)
        }
        
        view.addSubview(scrollView)
        view.addSubview(nextButton)

        scrollView.snp.makeConstraints { make in
            make.top.equalTo(calendarCollectionView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(nextButton.snp.top)
        }
        
        scrollView.addSubview(movieTypesCollectionView)
        movieTypesCollectionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalTo(30)
            make.centerX.equalToSuperview()
            make.height.equalTo(130)
        }
        
        scrollView.addSubview(timeSlotsCollectionView)
        timeSlotsCollectionView.snp.makeConstraints { make in
            make.top.equalTo(movieTypesCollectionView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.equalTo(470)
        }

        nextButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }
}
