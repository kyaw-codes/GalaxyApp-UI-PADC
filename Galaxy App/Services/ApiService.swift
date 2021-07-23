//
//  ApiService.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 19/07/2021.
//

import Foundation
import Alamofire

struct ApiService {
    
    static let shared = ApiService()
    
    private init() {}
    
    // MARK: - Authentication
    
    func signUpWithEmail(name: String,
                         email: String,
                         phone: String,
                         password: String,
                         completion: @escaping (Result<SignUpResponse, AFError>) -> Void) {
        let body = [
            "name": name,
            "phone": phone,
            "email": email,
            "password": password
        ]
        
        AF.request("\(baseUrl)/api/v1/register", method: .post, parameters: body).responseDecodable(of: SignUpResponse.self) { response in
            if let err = response.error {
                completion(.failure(err))
            }
            
            if let response = response.value {
                completion(.success(response))
            }
        }
    }
    
    func signIn(email: String,
                password: String,
                completion: @escaping (Result<SignInResponse, AFError>) -> Void) {
        let body = ["email": email, "password": password]
        
        AF.request("\(baseUrl)/api/v1/email-login", method: .post, parameters: body).responseDecodable(of: SignInResponse.self) { response in
            if let err = response.error {
                completion(.failure(err))
            }
            
            if let response = response.value {
                completion(.success(response))
            }
        }.validate(statusCode: 200..<300)
    }
    
    func fetchProfile(completion: @escaping(Result<ProfileResponse, AFError>) -> Void) {
        guard let token = UserDefaults.standard.value(forKey: keyAuthToken) as? String else {
            fatalError("No token found")
        }
        AF.request("\(baseUrl)/api/v1/profile", headers: [.authorization(bearerToken: token)]).responseDecodable(of: ProfileResponse.self) { response in
            if let err = response.error {
                completion(.failure(err))
            }
            
            if let response = response.value {
                completion(.success(response))
            }
        }
    }
    
    func logOut(completion: @escaping () -> Void) {
        guard let token = UserDefaults.standard.value(forKey: keyAuthToken) as? String else {
            fatalError("No token found")
        }
        
        AF.request("\(baseUrl)/api/v1/logout", headers: [.authorization(bearerToken: token)]).response { response in
            UserDefaults.standard.removeObject(forKey: keyAuthToken)
            completion()
        }
    }
    
    // MARK: - Movies
    
    enum MovieFetchType: String {
        case nowShowing = "current"
        case coming = "comingsoon"
    }
    
    func fetchMovies(movieType: MovieFetchType = .nowShowing,
                     recieving demand: Int = 0,
                     completion: @escaping (Result<MovieResponse, AFError>) -> Void) {
        
        var urlString = "\(baseUrl)/api/v1/movies?status=\(movieType.rawValue)"
        if demand > 0 {
            urlString.append("&take=\(demand)")
        }
        
        AF.request(urlString).responseDecodable(of: MovieResponse.self) { response in
            if let err = response.error {
                completion(.failure(err))
            }
            
            if let response = response.value {
                completion(.success(response))
            }
        }.validate(statusCode: 200..<300)
    }
    
    func getMovieDetail(_ id: Int, completion: @escaping (Result<MovieDetailResponse, AFError>) -> Void) {
        AF.request("\(baseUrl)/api/v1/movies/\(id)").responseDecodable(of: MovieDetailResponse.self) { response in
            if let err = response.error {
                completion(.failure(err))
            }
            
            if let response = response.value {
                completion(.success(response))
            }
        }.validate(statusCode: 200..<300)
    }
    
    // MARK: - Cinema Time Slot
    func fetchCinemaDayTimeSlots(movieId: Int,
                                 date: String,
                                 completion: @escaping (Result<CinemaResponse, AFError>) -> Void) {
        let urlString = "\(baseUrl)/api/v1/cinema-day-timeslots?movie_id=\(movieId)&date=\(date)"
        guard let token = UserDefaults.standard.value(forKey: keyAuthToken) as? String else {
            fatalError("No token found")
        }
        
        AF.request(urlString, headers: [.authorization(bearerToken: token)]).responseDecodable(of: CinemaResponse.self) { response in
            if let err = response.error {
                completion(.failure(err))
            }
            
            if let response = response.value {
                completion(.success(response))
            }
        }.validate(statusCode: 200 ..< 300)
        
    }
    
    // MARK: - Cinema Seat Plan
    func fetchSeatPlan(timeslodId: Int,
                       date: Date,
                       completion: @escaping (Result<CinemaSeatResponse, AFError>) -> Void) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        let urlString = "\(baseUrl)/api/v1/seat-plan?cinema_day_timeslot_id=\(timeslodId)&booking_date=\(formatter.string(from: date))"
        guard let token = UserDefaults.standard.value(forKey: keyAuthToken) as? String else {
            fatalError("No token found")
        }
        
        AF.request(urlString, headers: [.authorization(bearerToken: token)]).responseDecodable(of: CinemaSeatResponse.self) { response in
            if let err = response.error {
                completion(.failure(err))
            }
            
            if let response = response.value {
                completion(.success(response))
            }
        }.validate(statusCode: 200 ..< 300)
    }
    
    // MARK: - Snack List
    func fetchSnakcList(completion: @escaping (Result<SnackResponse, AFError>) -> Void) {
        guard let token = UserDefaults.standard.value(forKey: keyAuthToken) as? String else {
            fatalError("No token found")
        }
        
        AF.request("\(baseUrl)/api/v1/snacks", headers: [.authorization(bearerToken: token)]).responseDecodable(of: SnackResponse.self) { response in
            if let err = response.error {
                completion(.failure(err))
            }
            
            if let response = response.value {
                completion(.success(response))
            }
        }.validate(statusCode: 200 ..< 300)
    }
    
    // MARK: - Payment Methods
    func fetchPayments(completion: @escaping (Result<PaymentMethodResponse, AFError>) -> Void) {
        guard let token = UserDefaults.standard.value(forKey: keyAuthToken) as? String else {
            fatalError("No token found")
        }
        
        AF.request("\(baseUrl)/api/v1/payment-methods", headers: [.authorization(bearerToken: token)]).responseDecodable(of: PaymentMethodResponse.self) { response in
            if let err = response.error {
                completion(.failure(err))
            }
            
            if let response = response.value {
                completion(.success(response))
            }
        }.validate(statusCode: 200 ..< 300)
    }
    
    // MARK: - Card
    func createNewCard(cardNo: String,
                       cardHolder: String,
                       expirationDate: String,
                       cvc: String,
                       completion: @escaping(Result<Array<Card>, AFError>) -> Void) {
        guard let token = UserDefaults.standard.value(forKey: keyAuthToken) as? String else {
            fatalError("No token found")
        }
        
        let reqBody = [
            "card_number" : cardNo,
            "card_holder" : cardHolder,
            "expiration_date" : expirationDate,
            "cvc" : cvc
        ]
        
        AF.request("\(baseUrl)/api/v1/card",
                   method: .post,
                   parameters: reqBody,
                   headers: [.authorization(bearerToken: token)])
            .responseDecodable(of: CardResponse.self) { response in
                if let err = response.error {
                    completion(.failure(err))
                }
                
                if let response = response.value {
                    completion(.success(response.data))
                }
            }.validate(statusCode: 200 ..< 300)
    }
    
    // MARK: - Checkout
    func checkout(_ checkoutData: CheckoutData, completion: @escaping (Result<VoucherResponse, AFError>) -> Void) {
        guard let token = UserDefaults.standard.value(forKey: keyAuthToken) as? String else {
            fatalError("No token found")
        }
        
        AF.request("\(baseUrl)/api/v1/checkout",
                   method: .post,
                   parameters: checkoutData,
                   encoder: JSONParameterEncoder.default,
                   headers: [.authorization(bearerToken: token)]).responseDecodable(of: VoucherResponse.self) { response in
                    if let err = response.error {
                        completion(.failure(err))
                    }
                    
                    if let response = response.value {
                        completion(.success(response))
                    }
                   }
    }
}
