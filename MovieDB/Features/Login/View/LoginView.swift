//
//  LoginView.swift
//  MovieDB
//
//  Created by Himan Dhawan on 3/2/23.
//

import SwiftUI

struct LoginView: View {
    
    @StateObject var viewModel : LoginViewModel
    @State private var orientation = UIDeviceOrientation.unknown
    @State private var previousOrientation = UIDeviceOrientation.unknown



    init(loginService : LoginDataServiceProtocol){
        _viewModel = StateObject(wrappedValue: LoginViewModel.init(loginService: loginService))
    }
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ZStack {
                    
                    fullImage
                        .ignoresSafeArea()

                    LoginFormView(viewModel: viewModel)
                    
                    if viewModel.isLoading {
                        CustomLoadingIndicator()
                    }
                    
                }
            }
            
        }
        .onRotate { newOrientation in
            previousOrientation = orientation
            orientation = newOrientation
        }
                
    }
    
    var fullImage : some View {
        Image("background")
            .frame(width: UIScreen.main.bounds.width,height: UIScreen.main.bounds.height)
            .aspectRatio(contentMode: .fit)
            .opacity(1)
            .overlay {
                Color.black
                    .opacity(0.6)
            }
    }
    
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(loginService: LoginDataService())
    }
}
