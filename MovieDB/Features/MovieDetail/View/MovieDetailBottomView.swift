//
//  MovieDetailBottomView.swift
//  MovieDB
//
//  Created by Himan Dhawan on 3/18/23.
//

import SwiftUI

struct MovieDetailBottomView: View {
    let viewModel : MovieDetailViewModel
    var body: some View {
        ZStack {
            VStack {
                Rectangle()
                    .frame(width: 40,height: 5)
                    .cornerRadius(10)
                Text(viewModel.movie.title)
                    .font(Font.Heading.medium)
                    .foregroundColor(Color.Text.charcoal)
                Text(viewModel.movie.overview)
                    .font(Font.Body.small)
                    .foregroundColor(Color.Text.grey)
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .padding(.top,10)
            .background(Color.Text.systemBlack)
            .cornerRadius(30)
        }
        .ignoresSafeArea(edges : .bottom)
    }
}

struct MovieDetailBottomView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailBottomView(viewModel: .init(movie: .init(id: 123, adult: false, originalTitle: "RRR", overview: "RRR is very good movie", title: "RRR", posterPath: "/ngl2FKBlU4fhbdsrtdom9LVLBXw.jpg", releaseDate: "12-20-23", voteAverage: 2)))
    }
}
