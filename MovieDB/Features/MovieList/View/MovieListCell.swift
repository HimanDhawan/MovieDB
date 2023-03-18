//
//  MovieListCell.swift
//  MovieDB
//
//  Created by Himan Dhawan on 3/17/23.
//

import SwiftUI

struct MovieListCell: View {
    var movie : Movies
    var viewModel : MovieListCellViewModel = MovieListCellViewModel()
    var body: some View {
        HStack(alignment: .top) {
            AsyncImage(url: viewModel.getImageURL(movie: movie)){ image in
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
                Text(movie.originalTitle)
                    .font(Font.Heading.medium)
                    .foregroundColor(Color.Text.charcoal)
                Text(movie.overview)
                    .font(Font.Body.small)
                    .foregroundColor(Color.Text.grey)
                Spacer()
            }
        }
    }
}
