//
//  Credentials.swift
//  My Secure App
//
//  Created by Stewart Lynch on 2021-05-27.
//

import Foundation

struct Credentials: Codable {
    var email: String = ""
    var password: String = ""
    
    
    func encoded()->String{
        let encoder = JSONEncoder()
        let credintialsData = try! encoder.encode(self)
        return String(data: credintialsData, encoding: .utf8)!
    }

    
    static func decode(_ credintialsString:String)->Credentials{
        let decoder = JSONDecoder()
        let jsonData = credintialsString.data(using: .utf8)!
        let credintials = try! decoder.decode(Credentials.self, from: jsonData)
        return credintials
        
    }
}
