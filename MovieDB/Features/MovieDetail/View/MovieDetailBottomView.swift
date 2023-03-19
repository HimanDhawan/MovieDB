//
//  MovieDetailBottomView.swift
//  MovieDB
//
//  Created by Himan Dhawan on 3/18/23.
//

import SwiftUI

struct MovieDetailBottomView: View {
    @StateObject var viewModel : MovieDetailViewModel
    var body: some View {
        VStack(){
            Rectangle()
                .frame(width: 40,height: 5)
                .cornerRadius(10)
            VStack(alignment:.leading) {
                Text(viewModel.movie.title)
                    .font(Font.Heading.medium)
                    .foregroundColor(Color.Text.charcoal)
                    .padding()
                Text("Release date : " + viewModel.movie.releaseDate)
                    .font(Font.Body.smallSemiBold)
                    .foregroundColor(Color.Text.grey)
                    .padding(.leading)
                Text("Vote Average : " + viewModel.movie.voteAverage.description)
                    .font(Font.Body.smallSemiBold)
                    .foregroundColor(Color.Text.grey)
                    .padding(.leading)
                Text(viewModel.movie.overview)
                    .font(Font.Body.smallDescription)
                    .foregroundColor(Color.Text.grey)
                    .padding()
                Text("Similar Movies")
                    .font(Font.Heading.medium)
                    .foregroundColor(Color.Text.charcoal)
            }
            
                
            ScrollView(.horizontal,showsIndicators: false) {
                LazyHStack {
                    ForEach(viewModel.similarMovies) { movie in
                        SimilarMovieCellView(viewModel: .init(movie: movie))
                                .frame(width:150)
                        
                    }
                }
            }
            .frame(height: 200)
            
        }
        .frame(maxWidth: .infinity)
        .padding(.top,10)
        .background(Color.Text.systemBlack)
        .cornerRadius(20)
        .onAppear{
            self.viewModel.getSimilarMovies()
        }
    }
}

struct MovieDetailBottomView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailBottomView(viewModel: .init(movie: .init(id: 123, adult: false, originalTitle: "RRR", overview: "RRR is very good movie", title: "RRR", posterPath: "/ngl2FKBlU4fhbdsrtdom9LVLBXw.jpg", releaseDate: "12-20-23", voteAverage: 2)))
    }
}
