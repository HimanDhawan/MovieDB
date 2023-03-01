//
//  ContentView.swift
//  MovieDB
//
//  Created by Himan Dhawan on 9/16/22.
//

import SwiftUI
//import XCTest

struct ContentView: View {
    @State var username : String = ""
    @State var password : String = ""
    
    init(){
        UITableView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        ScrollView {
            VStack() {
                Text("TMBD")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .frame(width: UIScreen.main.bounds.width, height: 0, alignment: .center)
                    .background(Color.red)
                    .padding(EdgeInsets.init(top: 120, leading: 0, bottom: 100, trailing: 0))
                    .foregroundColor(Color.white)
                
                
                Form {
                    Section(header: Text("Enter user name and password").foregroundColor(Color.primary).fontWeight(.black).padding(.bottom)) {
                        
                        HStack {
                            Image(systemName: "person.circle")
                            TextField(text: $username, prompt: Text("Username")) {

                            }
                        }
                        
                        HStack {
                            Image(systemName: "lock")
                            SecureField(text: $password, prompt: Text("Password")) {

                            }
                        }
                        
                    }

                }
                .opacity(0.9)
                .padding(EdgeInsets.init(top:0, leading: 0, bottom: 0, trailing: 0))
                .frame(width: UIScreen.main.bounds.width, height: 180, alignment: .center)
                .background(Color.black)
                
                
                
                Button ( action :{

                }) {
                    Text("LOGIN")
                        .fontWeight(.heavy)
                        .frame(width: UIScreen.main.bounds.width-40 , height: 50, alignment: .center)
                }
                .background(Color("LoginButton"))
                .foregroundColor(Color("LoginButtonText"))
                .cornerRadius(5)

                
                    
            }
        }
        .background(fullImage)
        .frame(alignment: .center)
        .edgesIgnoringSafeArea(.all)
        
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
