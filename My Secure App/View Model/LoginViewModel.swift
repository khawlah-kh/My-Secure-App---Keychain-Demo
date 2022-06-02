//
//  LoginViewModel.swift
//  MySecureApp
//
//  Created by khawlah khalid on 01/06/2022.
//

import Foundation


class LoginViewModel : ObservableObject {
    @Published var credentials = Credentials()
    @Published var isLoading = false
    @Published var error : Authentication.AuthenticationError?
    @Published var storeCrededintialsNext = false
    
    var isDisabled:Bool{
         credentials.email.isEmpty ||  credentials.password.isEmpty
    }
    
    
    func login(completion:@escaping(Bool)->()){
        DispatchQueue.main.async {
            self.isLoading = true
        
            APIService.shared.login(credentials: self.credentials) { result in
            self.isLoading = false
            switch result {
            case .success:
                if self.storeCrededintialsNext{
                    if KeychainStorage.saveCredentials(self.credentials){
                        self.storeCrededintialsNext = false
                    }
                }
                completion(true)
            case .failure(let authError):
                self.error=authError
                self.credentials=Credentials()
                completion(false)
            }
        }
        }
       
        
        
    }
    
    
}
