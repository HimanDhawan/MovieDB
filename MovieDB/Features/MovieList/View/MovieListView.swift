//
//  MovieListView.swift
//  MovieDB
//
//  Created by Himan Dhawan on 3/14/23.
//

import SwiftUI



struct MovieListView: View {
    
    @StateObject var viewModel : MovieListViewModel
    
    init(movies : [Movies]) {
        _viewModel = StateObject(wrappedValue: MovieListViewModel.init(movie: movies))
    }
    
    var body: some View {
        
        VStack {
            List(viewModel.movies) { movie in
                MovieListCell(movie: movie)
                    .listRowInsets(EdgeInsets(top: 5, leading: 5, bottom: 10, trailing: 5))
                    .frame(minHeight: 200)
            }
            .navigationTitle("Top Movies")
        }
        
    }
        
    
}

struct MovieListView_Previews: PreviewProvider {
    static var previews: some View {
        MovieListView(movies: [])
    }
}
