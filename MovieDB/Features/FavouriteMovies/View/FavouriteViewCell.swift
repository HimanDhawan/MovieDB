//
//  FavouriteViewCell.swift
//  MovieDB
//
//  Created by Himan Dhawan on 4/6/23.
//

import SwiftUI

struct FavouriteViewCell: View {
    
    @StateObject var viewModel : MovieListCellViewModel
    
    init(movie: Movies, dataService : MovieListCellDataServiceProtocol = MovieListCellDataService() ) {
        _viewModel = StateObject(wrappedValue: MovieListCellViewModel.init(movie: movie, dataService: dataService))
    }
    
    var body: some View {
        VStack {
            NavigationLink (destination: MovieDetailView(movie: self.viewModel.movie)) {
                HStack(alignment: .top,spacing: 10) {
                    if let image = viewModel.image {
                        Image(uiImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(10)
                            .shadow(radius: 20)
                            .padding(.top,10)
                            .frame(width: 90, height: 124)
                            
                    } else {
                        ProgressView()
                            .frame(width: 90, height: 124)
                    }
                            
                    VStack(alignment: .leading) {
                        Text(viewModel.movie.originalTitle)
                            .font(Font.Heading.smallTitle)
                            .foregroundColor(Color.Text.charcoal)
                        Text("Release date : \(viewModel.movie.releaseDate?.description ?? "Not mentioned")" )
                            .font(Font.Body.small)
                            .foregroundColor(Color.Text.grey)
                        Text("Vote Average : \(viewModel.movie.voteAverage?.description ?? "Not mentioned")" )
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
}

struct FavouriteViewCell_Previews: PreviewProvider {
    static var previews: some View {
        FavouriteViewCell(movie: .init(id: 123, adult: false, originalTitle: "RRR", overview: "RRR is very good movie", title: "RRR", posterPath: "/ngl2FKBlU4fhbdsrtdom9LVLBXw.jpg", releaseDate: "12-20-23", voteAverage: 2))
    }
}
