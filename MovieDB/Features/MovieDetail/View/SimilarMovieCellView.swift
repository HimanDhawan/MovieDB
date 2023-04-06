//
//  SimilarMovieCellView.swift
//  MovieDB
//
//  Created by Himan Dhawan on 3/19/23.
//

import SwiftUI

struct SimilarMovieCellView: View {
    @StateObject var viewModel : SimilarMovieCellViewModel
    var body: some View {
        VStack(alignment: .leading,spacing: 5) {
            Spacer()
            if let image = viewModel.image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: viewModel.error ? .fit : .fill)
                    .cornerRadius(10)
                    .frame(width: 110, height: 144)
                    
            } else {
                ProgressView()
                    .frame(width: 110, height: 144)
            }
            
//            VStack(alignment: .leading) {
//                Text(viewModel.movie.originalTitle)
//                    .lineLimit(nil)
//                    .font(Font.Body.smallSemiBold)
//                    .foregroundColor(Color.Text.charcoal)
//                    .padding(.top,5)
//                
//            }
            Spacer()
        }
        .onAppear{
            Task {
                await viewModel.getImageURL()
            }
        }
    }
}

struct SimilarMovieCellView_Previews: PreviewProvider {
    static var previews: some View {
        SimilarMovieCellView(viewModel: .init(movie: .init(id: 123, adult: false, originalTitle: "RRR", overview: "RRR is very good movie", title: "RRR", posterPath: "/ngl2FKBlU4fhbdsrtdom9LVLBXw.jpg", releaseDate: "12-20-23", voteAverage: 2), dataService: SimilarMovieCellDataService()))
    }
}
