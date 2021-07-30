//
//  GoogleAuth.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 24/07/2021.
//

import Foundation
import GoogleSignIn
import UIKit

public class GoogleAuth : NSObject, GIDSignInDelegate {
    
    private var onGoogleAuthFailed: ((String)->Void)?
    private var onGoogleAuthSuccess: ((GoogleAuthProfileResponse)->Void)?
    
    public override init() {
        super.init()
    }
    
    public func start(view : UIViewController?, success: @escaping ((GoogleAuthProfileResponse)->Void), failure: @escaping ((String) -> Void) ) {
        //Set params
        GIDSignIn.sharedInstance()?.delegate = self
        GIDSignIn.sharedInstance().presentingViewController = view
        GIDSignIn.sharedInstance().clientID = OAUTH_ID_GOOGLE_SIGN_IN //Add your own OAuth Key
        
        //Trigger Prompt
        GIDSignIn.sharedInstance()?.signIn()
        
        print("Start Google Auth")
        
        //Handle response
        onGoogleAuthSuccess = { data in
            print("Success Google Auth")
            success(data)
        }
        
        onGoogleAuthFailed = { data in
            print("Failed Google Auth")
            failure(data)
        }
    }
    
    public func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            if (error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
                onGoogleAuthFailed?("The user has not signed in before or they have since signed out.")
            } else {
                onGoogleAuthFailed?("\(error.localizedDescription)")
            }
            return
        }
        
        // Perform any operations on signed in user here.
        let userId = user.userID ?? "" // For client-side use only!
        let token = user.authentication.idToken ?? ""
        let fullName = user.profile.name ?? ""
        let givenName = user.profile.givenName ?? ""
        let familyName = user.profile.familyName ?? ""
        let email = user.profile.email ?? ""
        
        let userData = GoogleAuthProfileResponse(
            id: userId,
            token: token,
            fullname: fullName,
            giveName: givenName,
            familyName: familyName,
            email: email
        )
        
        onGoogleAuthSuccess?(userData)
        
    }
    
}

public struct GoogleAuthProfileResponse {
    public let id, token, fullname, giveName, familyName, email : String
}
