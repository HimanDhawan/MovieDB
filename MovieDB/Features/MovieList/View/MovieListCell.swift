//
//  MovieListCell.swift
//  MovieDB
//
//  Created by Himan Dhawan on 3/17/23.
//

import SwiftUI

struct MovieListCell: View {
    @StateObject var viewModel : MovieListCellViewModel
    
    init(movie: Movies, dataService : MovieListCellDataServiceProtocol = MovieListCellDataService() ) {
        _viewModel = StateObject(wrappedValue: MovieListCellViewModel.init(movie: movie, dataService: dataService))
    }
    
    var body: some View {
        NavigationLink (destination: MovieDetailView(movie: self.viewModel.movie)) {
            HStack(alignment: .top) {
                if let image = viewModel.image {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(10)
                        .shadow(radius: 20)
                        .padding(.top,10)
                        .frame(width: 110, height: 144)
                        
                } else {
                    ProgressView()
                        .frame(width: 110, height: 144)
                }
                        
                VStack(alignment: .leading) {
                    Text(viewModel.movie.originalTitle)
                        .font(Font.Heading.medium)
                        .foregroundColor(Color.Text.charcoal)
                    Text(viewModel.movie.overview)
                        .font(Font.Body.small)
                        .foregroundColor(Color.Text.grey)
                    Spacer()
                }
            }
            .onAppear{
                Task(priority: .background) {
                    await viewModel.getImageURL()
                }
            }
        }
        
    }
}
