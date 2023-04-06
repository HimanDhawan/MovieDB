//
//  ProfileView.swift
//  MovieDB
//
//  Created by Himan Dhawan on 3/30/23.
//

import SwiftUI

struct ProfileView: View {
    
    let profile : UserDetails
    @StateObject var viewModel : UserProfileViewModel = UserProfileViewModel()
    
    init(profile: UserDetails) {
        self.profile = profile
    }
    
    var body: some View {
        
        List {
            
            Section {
                NavigationLink (destination: MyFavouriteMoviesView(viewModel: .init(dataService: MyFavouriteMovieDataService(accountID: self.profile.id.description, sessionID: "7b343e82757c85b4fb47bc9e24dcc3e96a7a9c7a")))) {
                    Button("My Favourites") {
                        self.viewModel.pushFavouriteScreen()
                    }
                }
                
                Button("My watchlist") {
                    
                }
                Button("My rate movies") {
                    
                }
            } header: {
                Text(viewModel.getInitials(from: profile.name))
                    .font(.system(size: 30))
                    .fontWeight(.bold)
                    .foregroundColor(Color.red)
                    .frame(maxWidth: .infinity)
                    .background{
                        Circle()
                            .foregroundColor(Color.Text.systemWhite.opacity(0.7))
                            .frame(width: 70,height: 70)
                    }
                    
                Text("List")
            }

        }

        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ProfileView(profile: .init(id: 1233, name: "Himan Dhawan", username: "himandhawan"))
        }
        
    }
}
