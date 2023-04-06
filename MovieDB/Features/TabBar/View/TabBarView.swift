//
//  TabBarView.swift
//  MovieDB
//
//  Created by Himan Dhawan on 3/30/23.
//

import SwiftUI

enum Tabs: String{
    case topMovies
    case profile
}

struct TabBarView: View {
    @State var selection: TabBarItem = .home
    @State var hideTabBar : Bool = false
    @StateObject var viewModel : TabBarViewModel
    
    init(movieListService: MovieListDataServiceProtocol, profileDataService : UserProfileDataServiceProtocol) {
        _viewModel = StateObject(wrappedValue: TabBarViewModel(movieListService: movieListService, profileDataService: profileDataService))
    }
    
    var body: some View {
        
        AppTabBarContainerView(selection: $selection, hideTabBar: $hideTabBar) {
            
            if let userDetails = self.viewModel.userDetails, let movies = self.viewModel.movies {
                NavigationView(content: {
                    MovieListView(movies: movies)
                        .onAppear {
                            hideTabBar = false
                        }
                        .onWillDisappear {
                            hideTabBar = true
                        }
                })
                .tabBarItem(tab: .home, selection: $selection)
                

                NavigationView(content: {
                    ProfileView(profile: userDetails)
                        .onAppear {
                            hideTabBar = false
                        }
                        .onWillDisappear {
                            hideTabBar = true
                        }
                })
                .tabBarItem(tab: .profile, selection: $selection)
            } else if let message = self.viewModel.errorMessage {
                AppErrorView(message: message) {
                    print("Retry")
                }
            } else {
                LoadingListView()
                    
            }
            
            

        }
        .onAppear{
            Task {
                await self.viewModel.getData()
            }
        }
        .navigationBarBackButtonHidden()
        
    }
    
}

struct TabBarView_Previews: PreviewProvider {
    
    static let tabs : [TabBarItem] = [.home,.favourite,.profile]

    
    static var previews: some View {
        TabBarView(movieListService: MovieListDataService(), profileDataService: UserProfileDataService(sessionID: "847a46c7dca4765d2f8f057e3994e3e199c596bf"))
    }
}
