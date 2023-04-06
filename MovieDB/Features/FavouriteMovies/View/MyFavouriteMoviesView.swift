//
//  MyFavouriteMoviesView.swift
//  MovieDB
//
//  Created by Himan Dhawan on 4/1/23.
//

import SwiftUI

struct MyFavouriteMoviesView: View {
    @StateObject var viewModel : MyFavouriteMovieViewModel
    var body: some View {
        if let movies = viewModel.movies {
            List(movies) { movie in
                FavouriteViewCell(movie: movie)
            }
        } else if let message = self.viewModel.error {
            AppErrorView(message: message) {
                print("Retry")
            }
        } else {
            LoadingListView()
                .onAppear{
                    Task {
                        await self.viewModel.getFavouriteMovies()
                    }
                }
        }
            
        
    }
    
}

struct MyFavouriteMoviesView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MyFavouriteMoviesView(viewModel: .init(dataService: MyFavouriteMovieDataService(accountID: "13744211", sessionID: "7b343e82757c85b4fb47bc9e24dcc3e96a7a9c7a")))
        }
    }
}
