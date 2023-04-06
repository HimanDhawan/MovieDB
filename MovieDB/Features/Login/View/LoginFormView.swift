//
//  LoginFormView.swift
//  MovieDB
//
//  Created by Himan Dhawan on 3/28/23.
//

import SwiftUI

struct LoginFormView: View {
    
    @ObservedObject var viewModel : LoginViewModel
    
    var body: some View {
        ScrollView {
            
            VStack() {
                Spacer(minLength: 100)
                Text("The Movie DB")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .frame(width: UIScreen.main.bounds.width, height: 0, alignment: .center)
                    .foregroundColor(Color.white)
                    .padding(.top,30)
                Form {
                    Section(header: Text("Enter user name and password").foregroundColor(Color.primary).fontWeight(.bold).padding(.bottom)) {
                        
                        HStack {
                            Image(systemName: "person.circle")
                            TextField(text: $viewModel.userName, prompt: Text("Username")) {

                            }
                            .autocorrectionDisabled(true)
                            .textInputAutocapitalization(.never)
                            .overlay(alignment: .trailing) {
                                
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
                .padding(EdgeInsets.init(top:30, leading: 10, bottom: 10, trailing: 10))
                .frame(height: 220, alignment: .center)
                
                Button ( action :{
                    Task {
                        await viewModel.loginTapped()
                    }
                    
                }) {
                    Text("LOGIN")
                        .fontWeight(.heavy)
                        .frame(width: UIScreen.main.bounds.width-20 , height: 50, alignment: .center)
                }
                .frame(height: 50, alignment: .center)
                .background(
                    
                    NavigationLink(destination: TabBarView(movieListService: MovieListDataService(), profileDataService: UserProfileDataService(sessionID: self.viewModel.session)), isActive: $viewModel.navigateToNextScreen) {
                        EmptyView()
                    }
                    .hidden()
                )
                
                .background((self.viewModel.validPassword && self.viewModel.validUserName) ? Color("LoginButton") : .gray)
                .foregroundColor(Color("LoginButtonText"))
                .cornerRadius(5)
                .opacity((self.viewModel.validPassword && self.viewModel.validUserName) ? 1.0 : 0.5)
                .disabled((self.viewModel.validPassword && self.viewModel.validUserName) ? false : true)
                .alert(isPresented: $viewModel.showError) {
                    return Alert(title: Text("Error"),message: Text(self.viewModel.error))
                }

            }
            
        }
    }
}

struct LoginFormView_Previews: PreviewProvider {
    static var previews: some View {
        LoginFormView(viewModel: .init(loginService: LoginDataService()))
        
    }
}
