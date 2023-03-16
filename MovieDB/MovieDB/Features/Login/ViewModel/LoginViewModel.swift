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
    
    @Published var validUserName : Bool = false
    @Published var validPassword : Bool = false

    @Published var userName : String = ""
    @Published var password : String = ""
    
    var anyCancelabeles : Set<AnyCancellable> = []
    
    let apiRouter = APIRouter<OnboardingAPIRequest>()
    
    init() {
        self.addSubscribers()
    }
    
}

// MARK: - IB Actions

extension LoginViewModel {
    func loginTapped() {
        if let publisher = apiRouter.request(.createRequestToken(apiKey: token)) {
            publisher
                .sink { completion in
                    print("----completion-----")
                    print(completion)
                    print("---------")
                } receiveValue: { value in
                    print("-----value----")
                    print(value)
                    print("---------")
                }
                .store(in: &anyCancelabeles)

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
