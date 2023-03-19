//
//  SimilarMovieCellView.swift
//  MovieDB
//
//  Created by Himan Dhawan on 3/19/23.
//

import SwiftUI

struct SimilarMovieCellView: View {
    let viewModel : SimilarMovieCellViewModel
    var body: some View {
        VStack(alignment: .center,spacing: 10) {
            AsyncImage(url: viewModel.getImageURL()){ image in
                
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
                    .lineLimit(nil)
                    .font(Font.Body.smallSemiBold)
                    .foregroundColor(Color.Text.charcoal)
                    .padding(.top,20)
                
            }
            Spacer()
        }
    }
}

struct SimilarMovieCellView_Previews: PreviewProvider {
    static var previews: some View {
        SimilarMovieCellView(viewModel: .init(movie: .init(id: 123, adult: false, originalTitle: "RRR", overview: "RRR is very good movie", title: "RRR", posterPath: "/ngl2FKBlU4fhbdsrtdom9LVLBXw.jpg", releaseDate: "12-20-23", voteAverage: 2)))
    }
}
