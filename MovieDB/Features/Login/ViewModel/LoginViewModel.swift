//
//  LoginViewModel.swift
//  MovieDB
//
//  Created by Himan Dhawan on 3/2/23.
//

import Foundation
import Combine

// MARK: - LoginViewModel


final class LoginViewModel : ObservableObject {
    
    let token = "076c9dad29e213f91dbbe7a82aa1da1d"
    
    var session : String = ""
    
    @Published var validUserName : Bool = false
    @Published var validPassword : Bool = false
    
    @Published var userName : String = "himandhawan"
    @Published var password : String = "Champion_movie01"
    
    @Published var error : String = ""
    @Published var showError : Bool = false
    
    @Published var isLoading = false
    
    @Published var navigateToNextScreen : Bool = false
    
    var anyCancelabeles : Set<AnyCancellable> = []
    
    let loginService : LoginDataServiceProtocol
    
    init(loginService: LoginDataServiceProtocol) {
        self.loginService = loginService
        self.addSubscribers()
    }
    
}

// MARK: - IB Actions

extension LoginViewModel {
    
    func loginTapped() async {
        do {
            await MainActor.run(body: {
                isLoading = true
            })
            
            let session =  try await self.loginService.login(userName: userName, password: password)
            
            if let sessionID = session.sessionID {
                await MainActor.run(body: {
                    
                    isLoading = false
                    navigateToNextScreen = true
                    self.session = sessionID
                })
            } else if let statusMessage = session.statusMessage {
                throw NSError.init(domain: "Login Error \(statusMessage)", code: 101, userInfo: [NSLocalizedDescriptionKey: LoginError.invalidSession.localizedDescription])
            }
            
        } catch {
            await MainActor.run(body: {
                isLoading = false
                self.error = error.localizedDescription
                showError = true
                print(error)
            })
            
        }
    }
        
}

// MARK: - Subscribers

extension LoginViewModel {
    
    private func addSubscribers() {
        self.addTextFieldSubscribersForValidUsername()
        self.addTextFieldSubscribersForValidPassword()
    }
    
    private func addTextFieldSubscribersForValidUsername() {
        $userName
            .map { (userName) in
                if userName.count > 3 {
                    return true
                } else {
                    return false
                }
            }
            .sink { [weak self] isValid in
                self?.validUserName = isValid
            }
            .store(in: &anyCancelabeles)
    }
    
    private func addTextFieldSubscribersForValidPassword() {
        $password
            .map { (password) in
                if password.count > 5 {
                    return true
                } else {
                    return false
                }
            }
            .sink { [weak self] isValid in
                self?.validPassword = isValid
            }
            .store(in: &anyCancelabeles)
    }
}
// MARK: -
