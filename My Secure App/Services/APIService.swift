//
//  APIService.swift
//  My Secure App
//
//  Created by Stewart Lynch on 2021-05-26.
//

import Foundation

class APIService {
    static let shared = APIService()
    enum APIError: Error {
        case error
    }

    func login(credentials: Credentials,
               completion: @escaping (Result<Bool,Authentication.AuthenticationError>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            if credentials.password == "password" {
                completion(.success(true))
            } else {
                completion(.failure(Authentication.AuthenticationError.invalidCredintals))
            }
        }
    }
}
