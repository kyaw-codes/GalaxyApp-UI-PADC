//
//  ApiService.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 19/07/2021.
//

import Foundation
import Alamofire

public enum MovieFetchType: String {
    case nowShowing = "current"
    case coming = "comingsoon"
}

class ApiServiceImpl : ApiService {

    static let shared = ApiServiceImpl()
    
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
        
        AF.request(
            "\(baseUrl)/api/v1/register",
            method: .post, parameters: body
        ).responseDecodable(of: SignUpResponse.self, emptyResponseCodes: [200, 204, 205]) { response in
            if let err = response.error {
                completion(.failure(err))
            }
            
            if let response = response.value {
                completion(.success(response))
            }
        }
        .validate()
    }
    
    func signUpWithFb(
        vc: UIViewController,
        name: String,
        email: String,
        phone: String,
        password: String,
        completion: @escaping (Result<SignUpResponse, AFError>) -> Void
    ) {
    
        let fbAuth = FacebookAuth()
        fbAuth.start(vc: vc) { response in
            let id = response.id
            let body = FbSignUpRequestBody(name: name, email: email, phone: phone, password: password, id: id)

            AF.request(
                "\(baseUrl)/api/v1/register",
                method: .post,
                parameters: body
            ).responseDecodable(of: SignUpResponse.self, emptyResponseCodes: [200, 204, 205]) { response in
                if let err = response.error {
                    completion(.failure(err))
                    return
                }

                if let data = response.value {
                    UserDefaults.standard.setValue(id, forKey: keyFBId)
                    completion(.success(data))
                    return
                }
            }
        } failure: { failure in
            print("[Failed when sign up with facebook] \(failure)")
        }
    }
    
    func signUpWithGoogle(
        vc: UIViewController,
        name: String,
        email: String,
        phone: String,
        password: String,
        completion: @escaping (Result<SignUpResponse, AFError>) -> Void
    ) {
        let googleAuth = GoogleAuth()
        
        googleAuth.start(view: vc) { response in
//            let id = response.id
//            let body = GoogleSignUpRequestBody(name: name, email: email, phone: phone, password: password, id: id)
            
            print("Api service \(response.id)")
            
//            AF.request(
//                "\(baseUrl)/api/v1/register",
//                method: .post,
//                parameters: body
//            ).responseDecodable(of: SignUpResponse.self, emptyResponseCodes: [200, 204, 205]) { response in
//                if let err = response.error {
//                    completion(.failure(err))
//                    return
//                }
//
//                if let data = response.value {
//                    UserDefaults.standard.setValue(id, forKey: keyGoogleId)
//                    completion(.success(data))
//                    return
//                }
//            }
        } failure: { error in
            print("[Failed when sign up with google] \(error)")
        }

    }

    func signIn(email: String, password: String, completion: @escaping (Result<SignInResponse, AFError>) -> Void) {
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
    
    func signInWithFacebook(completion: @escaping (Result<SignInResponse, AFError>) -> Void) {
        guard let fbId = UserDefaults.standard.value(forKey: keyFBId) as? String else {
            fatalError("[Error while sign in with fb] Facebook ID not found. Sign up with Facebook first.")
        }
        
        AF.request(
            "\(baseUrl)/api/v1/facebook-login",
            method: .post,
            parameters: ["access-token": fbId]
        ).responseDecodable(of: SignInResponse.self) { response in
            if let err = response.error {
                completion(.failure(err))
                return
            }
            
            if let data = response.value {
                completion(.success(data))
                UserDefaults.standard.setValue(data.token, forKey: keyAuthToken)
                return
            }
        }.validate(statusCode: 200..<300)
    }
    
    func fetchProfile(completion: @escaping(Result<ProfileResponse, AFError>) -> Void) {
        let token = getToken()
        
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
        let token = getToken()
        
        AF.request("\(baseUrl)/api/v1/logout", headers: [.authorization(bearerToken: token)]).response { response in
            UserDefaults.standard.removeObject(forKey: keyAuthToken)
            completion()
        }
    }
    
    // MARK: - Movies
    
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
        let token = getToken()
        
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
        let token = getToken()
        
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
        let token = getToken()
        
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
        let token = getToken()
        
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
        let token = getToken()
        
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
        let token = getToken()
        
        AF.request("\(baseUrl)/api/v1/checkout",
                   method: .post,
                   parameters: checkoutData,
                   encoder: JSONParameterEncoder.default,
                   headers: [.authorization(bearerToken: token)])
            .responseDecodable(of: VoucherResponse.self) { response in
                if let err = response.error {
                    completion(.failure(err))
                }
                
                if let response = response.value {
                    completion(.success(response))
                }
            }
    }
}
