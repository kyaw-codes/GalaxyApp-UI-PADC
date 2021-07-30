//
//  ApiService.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 29/07/2021.
//

import UIKit
import Alamofire

protocol ApiService {
    
    // MARK: - Auth
    
    func signUpWithEmail(
        name: String,
        email: String,
        phone: String,
        password: String,
        completion: @escaping (Result<SignUpResponse, AFError>) -> Void
    )
    
    func signUpWithFb(
        vc: UIViewController,
        name: String,
        email: String,
        phone: String,
        password: String,
        completion: @escaping (Result<SignUpResponse, AFError>) -> Void
    )
    
    func signUpWithGoogle(
        vc: UIViewController,
        name: String,
        email: String,
        phone: String,
        password: String,
        completion: @escaping (Result<SignUpResponse, AFError>) -> Void
    )
    
    func signIn(
        email: String,
        password: String,
        completion: @escaping (Result<SignInResponse, AFError>) -> Void
    )
    
    func signInWithFacebook(completion: @escaping (Result<SignInResponse, AFError>) -> Void)
    
    func fetchProfile(completion: @escaping(Result<ProfileResponse, AFError>) -> Void)
    
    func logOut(completion: @escaping () -> Void)
    
    // MARK: - Movies
    
    func fetchMovies(
        movieType: MovieFetchType,
        recieving demand: Int,
        completion: @escaping (Result<MovieResponse, AFError>) -> Void
    )
    
    func getMovieDetail(
        _ id: Int,
        completion: @escaping (Result<MovieDetailResponse, AFError>) -> Void
    )
    
    // MARK: - Cinema Time Slot
    func fetchCinemaDayTimeSlots(
        movieId: Int,
        date: String,
        completion: @escaping (Result<CinemaResponse, AFError>) -> Void
    )
    
    // MARK: - Cinema Seat Plan
    func fetchSeatPlan(
        timeslodId: Int,
        date: Date,
        completion: @escaping (Result<CinemaSeatResponse, AFError>) -> Void
    )
    
    // MARK: - Snack List
    func fetchSnakcList(completion: @escaping (Result<SnackResponse, AFError>) -> Void)
    
    // MARK: - Payment Methods
    func fetchPayments(completion: @escaping (Result<PaymentMethodResponse, AFError>) -> Void)
    
    // MARK: - Card
    func createNewCard(
        cardNo: String,
        cardHolder: String,
        expirationDate: String,
        cvc: String,
        completion: @escaping(Result<Array<Card>, AFError>) -> Void
    )
    
    // MARK: - Checkout
    func checkout(
        _ checkoutData: CheckoutData,
        completion: @escaping (Result<VoucherResponse, AFError>) -> Void
    )
}
