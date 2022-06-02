//
//  MySecureApp_App.swift
//  My Secure App
//
//  Created by Stewart Lynch on 2021-05-26.
//

import SwiftUI

@main
struct MySecureApp_App: App {
    @StateObject var authViewModel = Authentication()
    var body: some Scene {
        WindowGroup {
            if authViewModel.isAuthenticating{
                ContentView()
                    .environmentObject(authViewModel)
            }
            else{
                Login()
                    .environmentObject(authViewModel)
            }
     
           
        }
    }
}
