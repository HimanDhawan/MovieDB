//
//  LoginView.swift
//  MovieDB
//
//  Created by Himan Dhawan on 3/2/23.
//

import SwiftUI

struct LoginView: View {
    @StateObject var viewModel = LoginViewModel()
    
    init(){
        UITableView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                fullImage
                    .ignoresSafeArea()
                ScrollView {
                    VStack() {
                        Text("The Movie DB")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .frame(width: UIScreen.main.bounds.width, height: 0, alignment: .center)
                            .padding(EdgeInsets.init(top: 150, leading: 0, bottom: 100, trailing: 0))
                            .foregroundColor(Color.white)
                        
                        
                        Form {
                            Section(header: Text("Enter user name and password").foregroundColor(Color.primary).fontWeight(.bold).padding(.bottom)) {
                                
                                HStack {
                                    Image(systemName: "person.circle")
                                    TextField(text: $viewModel.userName, prompt: Text("Username")) {

                                    }.overlay(alignment: .trailing) {
                                        
                                        Image(systemName: "checkmark.circle.fill").foregroundColor(.green).opacity(self.viewModel.validUserName ? 1.0 : 0.0)
                                        
                                        Image(systemName: "xmark.circle.fill").foregroundColor(.red).opacity(self.viewModel.userName.count < 1 ? 0.0 : self.viewModel.validUserName ? 0.0 : 1.0 )
                                    }
                                }
                                
                                HStack {
                                    Image(systemName: "lock")
                                    SecureField(text: $viewModel.password, prompt: Text("Password")) {

                                    }.overlay(alignment: .trailing) {
                                        Image(systemName: "checkmark.circle.fill").foregroundColor(.green).opacity(self.viewModel.validPassword ? 1.0 : 0.0)
                                        
                                        Image(systemName: "xmark.circle.fill").foregroundColor(.red).opacity(self.viewModel.password.count < 1 ? 0.0 : self.viewModel.validPassword ? 0.0 : 1.0 )
                                        
                                    }
                                    
                                }
                                
                            }

                        }
                        .cornerRadius(10)
                        .opacity(0.9)
                        .padding(EdgeInsets.init(top:0, leading: 10, bottom: 10, trailing: 10))
                        .frame(width: UIScreen.main.bounds.width, height: 180, alignment: .center)
                        
                        
                        Button ( action :{
                            
                            viewModel.loginTapped()
                        }) {
                            Text("LOGIN")
                                .fontWeight(.heavy)
                                .frame(width: UIScreen.main.bounds.width-20 , height: 50, alignment: .center)
                        }
                        .background(
                            NavigationLink(destination: MovieListView(), isActive: $viewModel.navigateToNextScreen) {
                                EmptyView()
                            }
                            .hidden()
                        )
                        .background((self.viewModel.validPassword && self.viewModel.validUserName) ? Color("LoginButton") : .gray)
                        .foregroundColor(Color("LoginButtonText"))
                        .cornerRadius(5)
                        .opacity((self.viewModel.validPassword && self.viewModel.validUserName) ? 1.0 : 0.5)
                        .disabled((self.viewModel.validPassword && self.viewModel.validUserName) ? false : true)
                    }
                }
                
                
            }
        }
        

        
    }
    
    var fullImage : some View {
        Image("background")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .opacity(1)
            .overlay {
                Color.black
                    .opacity(0.6)
            }
    }
    
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
