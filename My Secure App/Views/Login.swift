//
//  Login.swift
//  LearnerApp
//
//  Created by khawlah khalid on 12/04/2022.
//

import SwiftUI

struct Login: View {
    @StateObject var loginViewModel = LoginViewModel()
    @EnvironmentObject var authViewModel : Authentication
    var body: some View {
        NavigationView{
            VStack(spacing: 8) {
                Text("Keychain Demo")
                    .font(.system(size: 48, weight: .semibold, design: .rounded))
                    .foregroundColor(Color.green)
                    .padding(.top,64)
                    .padding(.bottom,16)
                
                CustomTextField(text: $loginViewModel.credentials.email, placeholder: "Email", imageName: "envelope")
                    .padding(.horizontal)
                    .cornerRadius(10)
                    .foregroundColor(.white)
                    .keyboardType(.emailAddress)
                
                CustomSecureField(text: $loginViewModel.credentials.password, placeholder: "Password")
                    .padding(.horizontal)
                    .cornerRadius(10)
                    .foregroundColor(.white)
                
                
                if loginViewModel.isLoading{
                    ProgressView()
                }
                Button {
                    loginViewModel.login {success in
                        authViewModel.updateIsAuthentication(success: success)
                    }
                } label: {
                    Text("Login")
                        .foregroundColor(.white)
                        .font(.headline)
                        .frame(width: 360, height: 50)
                        .background(Color.green)
                        .clipShape(Capsule())
                        .padding()
                }
                .disabled(loginViewModel.isDisabled)
                
                if authViewModel.biometricType() != .none{
                    Button {
                        authViewModel.requestBiometricUnlock { result in
                            switch result{
                            case .success(let credintials):
                                DispatchQueue.main.async {
                                    loginViewModel.credentials = credintials
                                }
                                
                                loginViewModel.login { success in
                                    authViewModel.updateIsAuthentication(success: success)
                                }
                            case .failure(let error):
                                loginViewModel.error = error
                            }
                        }
                    } label: {
                        Image(systemName:authViewModel.biometricType().rawValue)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                    }
                    
                }
                
                
                
                
                Spacer()
            }
            .textInputAutocapitalization(TextInputAutocapitalization.never)
            .onTapGesture {
                UIApplication.shared.endEditing()
            }
            
        }
        .navigationBarHidden(true)
        .alert(item: $loginViewModel.error) { error in
            if error == .credintalsNotSaved{
                return Alert(title: Text("Credintials Not Saved"), message: Text(error.localizedDescription),primaryButton:.default(Text("Ok"),action: {
                    loginViewModel.storeCrededintialsNext = true
                }),secondaryButton:.cancel())
            }
            else{
                return Alert(title: Text("Invalid Login"), message: Text(error.localizedDescription))
            }
            
        }
    }
}


struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login()
            .environmentObject(Authentication())
    }
}
