//
//  CastMovieCellView.swift
//  MovieDB
//
//  Created by Himan Dhawan on 3/29/23.
//

import SwiftUI

struct CastMovieCellView: View {
    let viewModel : CastMovieCellViewModel
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
                    .frame(width: 90, height: 134)
            
            VStack(alignment: .leading) {
                Text(viewModel.cast.name)
                    .lineLimit(nil)
                    .font(Font.Body.smallSemiBold)
                    .foregroundColor(Color.Text.charcoal)
                    .padding(.top,20)
                
            }
            Spacer()
        }
    }
}

struct CastMovieCellView_Previews: PreviewProvider {
    static var previews: some View {
        CastMovieCellView(viewModel: .init(cast: .init(gender: 1, id: 6384, name: "Keanu Reeves", profilePath: "/4D0PpNI0kmP58hgrwGC3wCjxhnm.jpg", character: "John Wick")))
    }
}
