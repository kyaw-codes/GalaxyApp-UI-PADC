//
//  FacebookAuth.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 19/07/2021.
//

import FBSDKLoginKit
import UIKit

class FacebookAuth {
    
    public func start(vc : UIViewController?,
                      success: @escaping ((FacebookAuthProfileResponse) -> Void),
                      failure: @escaping ((String) -> Void)) {
        handShakeWithFacebookServer(vc: vc, success: {
            self.getUserFacebookData(success: { (data) in
                success(data)
            }) { (err) in
                failure(err)
            }
        }) { (err) in
            failure(err)
        }
    }
    
    fileprivate func handShakeWithFacebookServer(vc : UIViewController?,
                                                 success: @escaping (() -> Void),
                                                 failure: @escaping ((String) -> Void)) {
        
        guard let view = vc else {
            failure("Failed to reference view controller. Facebook login canceled.")
            return
        }
        
        let loginManager = LoginManager()
        loginManager.logOut()
        
        loginManager.logIn(permissions: ["public_profile","email"], from: view) { (result, error) in
            if let err = error {
                failure("FacebookLogin -> \(err.localizedDescription)")
                return
            }
            
            if result?.isCancelled ?? false {
                failure("Facebook Login Canceled")
                return
            }
            success()
        }
    }
    
    fileprivate func getUserFacebookData(success: @escaping ((FacebookAuthProfileResponse) -> Void),
                                         failure: @escaping ((String) -> Void)) {
        
        if((AccessToken.current) != nil) {
            
            let request = GraphRequest.init(graphPath: "me",
                                            parameters: ["fields":"id, name, picture.type(large), email,cover"],
                                            tokenString: AccessToken.current?.tokenString,
                                            version: nil,
                                            httpMethod: .get)
            
            request.start { (connection, result, error) in
                if error == nil {
                    guard let info = result as? [String: Any] else { return }
                    let facebookID = info["id"] as? String ?? ""
                    let userName = info["name"] as? String ?? ""
                    let keyExists = info["email"] != nil
                    var userEmail:String = ""
                    
                    if keyExists {
                        userEmail = info["email"] as! String
                    }
                    
                    let userProfile = "https://graph.facebook.com/\(info["id"]!)/picture?type=large&return_ssl_resources=1"
                    
                    let userData = FacebookAuthProfileResponse(id: facebookID,token: AccessToken.current?.tokenString ?? "",name: userName, email: userEmail, profilePic: userProfile)
                    
                    success(userData)
                } else {
                    failure(error?.localizedDescription ?? "Error Nil FacebookAuth")
                }
            }
            
        } else {
            failure("FBAccessToken is nil => [Debug :: FacebookAuth]")
        }
    }
}


public struct FacebookAuthProfileResponse {
    public let id, token, name, email, profilePic : String
}
