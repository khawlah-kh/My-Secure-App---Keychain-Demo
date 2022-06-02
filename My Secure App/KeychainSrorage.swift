//
//  KeychainSrorage.swift
//  MySecureApp
//
//  Created by khawlah khalid on 02/06/2022.
//

import Foundation
import SwiftKeychainWrapper

enum KeychainStorage{
    static let key = "credentials"
    static func getCredntials()->Credentials?{
        if let myCredentialsString = KeychainWrapper.standard.string(forKey: Self.key){
            let credentials = Credentials.decode(myCredentialsString)
            return credentials
        }else{
            return nil
        }
    }
    
    
    static func saveCredentials(_ credentials:Credentials)->Bool{
        let credentialsString =  credentials.encoded()
        if KeychainWrapper.standard.set(credentialsString, forKey: key){
            return true
        }
        return false
    }
    
}
