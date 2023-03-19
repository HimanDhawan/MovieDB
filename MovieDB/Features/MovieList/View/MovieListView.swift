//
//  MovieListView.swift
//  MovieDB
//
//  Created by Himan Dhawan on 3/14/23.
//

import SwiftUI



struct MovieListView: View {
    
    @StateObject var viewModel = MovieListViewModel()
    
    
    var body: some View {
        List(viewModel.movies) { movie in
            
            MovieListCell(viewModel: .init(movie: movie))
                .listRowInsets(EdgeInsets(top: 5, leading: 5, bottom: 10, trailing: 5))
                .frame(minHeight: 200)
                
        }
        .navigationTitle("Top Movies")
        .navigationBarTitleDisplayMode(.large)
        .navigationBarBackButtonHidden()
        .onAppear {
            self.viewModel.getAllPopularMovies()
        }
        .onDisappear{
            self.viewModel.isSelected = false
        }
    }
        
    
}

struct MovieListView_Previews: PreviewProvider {
    static var previews: some View {
        MovieListView()
    }
}
