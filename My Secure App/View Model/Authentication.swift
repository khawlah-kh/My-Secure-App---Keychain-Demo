//
//  Authentication.swift
//  MySecureApp
//
//  Created by khawlah khalid on 01/06/2022.
//

import SwiftUI
import LocalAuthentication

class Authentication : ObservableObject{
    
    @Published var isAuthenticating : Bool = false
    @Published var isAuthorized : Bool = false
    
    func updateIsAuthentication(success:Bool){
        withAnimation {
            isAuthenticating=success
        }
    }
    
    enum BiometricType : String{
        case none
        case faceid
        case touchid
    }
    enum AuthenticationError : Error , LocalizedError , Identifiable{
        case invalidCredintals
        case deniedAccess
        case noFaceIdEnrolled
        case noFingerPrintEnrolled
        case biometricError
        case credintalsNotSaved
        
        var id : String{
            localizedDescription
        }
        
        var errorDescription: String?{
            switch self {
            case .invalidCredintals:
                return NSLocalizedString("Either your email or password are incorrect. Please try again.", comment: "")
            case .deniedAccess:
                return NSLocalizedString("You have denied ccess. Please go to the settings app and locate this application and turn Face ID on.", comment: "")
            case .noFaceIdEnrolled:
                return NSLocalizedString("You have not registered any Face ID yet.", comment: "")
            case .noFingerPrintEnrolled:
                return NSLocalizedString("You have not registered any Fingerprints yet.", comment: "")
            case .biometricError:
                return NSLocalizedString("You have not registered any Fingerprints yet.", comment: "Your Face Id or Fingerprints were not recognized.")
            case .credintalsNotSaved:
                return NSLocalizedString("Your credintials have not been saved. Do you want to save them after the next successful login", comment: "")
            }
        }
        
    }
    
    func biometricType()->BiometricType{
        let authContext = LAContext()
        let _ = authContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil)
        switch authContext.biometryType{
        case .none:
            return .none
        case .touchID:
            return .touchid
        case .faceID:
            return .faceid
        @unknown default:
            return .none
        }
    }
    
    func requestBiometricUnlock(completion:@escaping((Result<Credentials,AuthenticationError>)->()))
    {
        let credentials : Credentials? = KeychainStorage.getCredntials()
        guard let credentials = credentials else {
            completion(.failure(AuthenticationError.credintalsNotSaved))
            return
        }

        let context = LAContext()
        var error : NSError?
        let canEvaluate = context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error)
        if let error = error {
            switch error.code{
            case -6 :
                completion(.failure(AuthenticationError.deniedAccess))
            case -7:
                if context.biometryType == .faceID{
                    completion(.failure(.noFaceIdEnrolled))
                }
                else {
                    completion(.failure(.noFingerPrintEnrolled))
                }
            default:
                completion(.failure(.biometricError))
            }
            return
        }
        
        if canEvaluate{
            if context.biometryType != .none{
                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Need to access credintials") { success, error in
                    if let error = error {
                        completion(.failure(.biometricError))
                    }
                    else{
                        completion(.success(credentials))
                    }
                }
            }
        }
    }
}
