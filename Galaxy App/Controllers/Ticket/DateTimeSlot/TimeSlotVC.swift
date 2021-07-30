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
    private let movieTypes: [MovieTypeVO] = [.init(title: "2D", isSelected: true), .init(title: "3D"), .init(title: "IMAX")]
    
    private var timeslots = [CinemaTimeSlotVO]() {
        didSet {
            timeslotDatasource.cinemas = timeslots
        }
    }
    
    // MARK: - Views
    
    let backButton = BackButton(iconColor: .white)
    let calendarCollectionView = CalendarCollectionView()
    let nextButton = CTAButton(title: "Next")
    let scrollView = UIScrollView(backgroundColor: .white)
    let movieTypesCollectionView = MovieTypeCollectionView()
    let timeSlotsCollectionView = TimeSlotCollectionView()
    let spinner = UIActivityIndicatorView(style: .large)
    
    // MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .galaxyViolet

        setupViews()
        
        calendarDatasource.dates = dates
        calendarDatasource.onDaySelected = onDaySelected(vo:)
        calendarCollectionView.dataSource = calendarDatasource
        
        movieTypesCollectionView.types = movieTypes
        movieTypesCollectionView.onMovieTypeSelected = onMovieTypeSelected(vo:)
        
        timeslotDatasource.onCinemaTimeSlotSelected = onCinemaTimeSlotSelected(cinemaId:timeslotId:)
        timeSlotsCollectionView.dataSource = timeslotDatasource

        fetchTimeSlots(date: Date().getApiDateString())
        
        backButton.addTarget(self, action: #selector(handleBackTapped), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(handleNextTapped), for: .touchUpInside)
    }
    
    // MARK: - Private Helper
    
    private func fetchTimeSlots(date: String) {
        spinner.startAnimating()
        ApiServiceImpl.shared.fetchCinemaDayTimeSlots(movieId: GlobalVoucherModel.instance.movieId, date: date) { [weak self] result in
            do {
                let response = try result.get()
                let cinemas = response.getCinemaVM() ?? []
                cinemas[0].timeslots[0].isSelected = true
                
                GlobalVoucherModel.instance.apply { model in
                    model.cinemaName = cinemas[0].cinema ?? ""
                    model.cinemaId = cinemas[0].cinemaID ?? -1
                    model.bookingTime = cinemas[0].timeslots[0].startTime ?? ""
                    model.timeslodId = cinemas[0].timeslots[0].cinemaDayTimeslotID ?? -1
                }
                
                self?.timeslots = cinemas
                self?.timeSlotsCollectionView.reloadData()
                self?.spinner.stopAnimating()
            } catch {
                print("[Error while fetching cinema day time slots] \(error)")
            }
        }
    }
    
    private func onDaySelected(vo: CalendarVO) {
        dates.forEach { $0.isSelected = $0.date == vo.date }
        calendarCollectionView.reloadData()
        fetchTimeSlots(date: vo.date.getApiDateString())
    }
    
    private func onMovieTypeSelected(vo: MovieTypeVO) {
        movieTypes.forEach { $0.isSelected = vo.title == $0.title }
        movieTypesCollectionView.reloadData()
        GlobalVoucherModel.instance.movieType = vo.title
    }
    
    private func onCinemaTimeSlotSelected(cinemaId: Int, timeslotId: Int) {
        GlobalVoucherModel.instance.apply { model in
            model.timeslodId = timeslotId
            model.cinemaId = cinemaId
        }
        
        timeslots.forEach { cinema in
            cinema.timeslots.forEach { timeslot in
                if timeslot.cinemaDayTimeslotID == timeslotId {
                    timeslot.isSelected = true
                } else {
                    timeslot.isSelected = false
                }
            }
        }
        
        timeSlotsCollectionView.reloadData()
    }

    // MARK: - Action Handler
    @objc private func handleBackTapped() {
        coordinator?.popToMovieDetail()
    }

    @objc private func handleNextTapped() {
        coordinator?.chooseSeat()
    }
}
