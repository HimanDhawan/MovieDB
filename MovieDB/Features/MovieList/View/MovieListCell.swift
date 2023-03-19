//
//  MovieListCell.swift
//  MovieDB
//
//  Created by Himan Dhawan on 3/17/23.
//

import SwiftUI

struct MovieListCell: View {
    var viewModel : MovieListCellViewModel
    
    var body: some View {
        NavigationLink (destination: MovieDetailView(viewModel: .init(movie: viewModel.movie))) {
            HStack(alignment: .top) {
                AsyncImage(url: viewModel.getImageURL(movie: viewModel.movie)){ image in
                    
                                image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .cornerRadius(10)
                                .shadow(radius: 20)
                                .padding(.top,40)
                                .padding(.trailing,5)
                                
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 110, height: 144)
                        
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
        }
        
    }
}
