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
    
    @Published var navigateToNextScreen : Bool = false
    
    var anyCancelabeles : Set<AnyCancellable> = []
    
    let apiRouter = APIRouter<OnboardingAPIRequest>()
    
    init() {
        self.addSubscribers()
    }
    
}

// MARK: - IB Actions

extension LoginViewModel {
    func loginTapped() {
        
        navigateToNextScreen = true
        return
        let publisher : AnyPublisher<RequestToken,Error> = apiRouter.request(.createRequestToken(apiKey: token))
        
        publisher
            .flatMap({ rToken in
                let publisher : AnyPublisher<RequestToken,Error> = self.apiRouter.request(.login(userName: self.userName, password: self.password, requestToken: rToken.requestToken, apiKey: self.token))
                return publisher
            })
            
//            .flatMap { rToken in
//                let publisher : AnyPublisher<RequestToken,Error> = self.apiRouter.request(.login(userName: self.userName, password: self.password, requestToken: rToken.requestToken, apiKey: self.token))
//                return publisher
//
//            }
        
        publisher
            .flatMap ({ rToken in
                let publisher : AnyPublisher<RequestToken,Error> = self.apiRouter.request(.login(userName: self.userName, password: self.password, requestToken: rToken.requestToken, apiKey: self.token))
                return publisher
            })
        
//            .sink { completion in
//                switch completion {
//                case .finished: print("Finished")
//                case .failure(let error): print("Error \(error)")
//                }
//            } receiveValue: { [weak self] value in
//                print("-----value----")
//                print(value)
//                self?.loginWithRequestToken(rToken: value.requestToken)
//                print("---------")
//            }
//            .store(in: &anyCancelabeles)
    }
    
    func loginWithRequestToken(rToken : String) {
        let publisher : AnyPublisher<RequestToken,Error> = apiRouter.request(.login(userName: userName, password: password, requestToken: rToken, apiKey: token))
        
        publisher
            .sink { completion in
                switch completion {
                case .finished: print("Finished")
                case .failure(let error): print("Error \(error)")
                }
            } receiveValue: { value in
                
            }
            .store(in: &anyCancelabeles)

    }
    
    func loginTappedWithCompletion() async {
        let router = APIRouter1<OnboardingAPIRequest,CreateRequestTokenAPIResponse>()
        router.request(.createRequestToken(apiKey: token)) { response in
            if let data = response.deSerializedData {
                
            }
        }
    }
    
    func loginTappedWithAsync() async {
        do {
            let router = APIRouter3<OnboardingAPIRequest,CreateRequestTokenAPIResponse>()
            let response = try await router.request(.createRequestToken(apiKey: token))
            print("response \(response?.deSerializedData)")
        } catch {
            print(error)
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
