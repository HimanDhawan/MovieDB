//
//  CastMovieCellView.swift
//  MovieDB
//
//  Created by Himan Dhawan on 3/29/23.
//

import SwiftUI

struct CastMovieCellView: View {
    @StateObject var viewModel : CastMovieCellViewModel
    var body: some View {
        VStack(alignment: .center,spacing: 10) {
            
            if let image = viewModel.image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: (viewModel.error == nil) ? .fill : .fit)
                    .cornerRadius(10)
                    .padding(.top,40)
                    .padding(.trailing,5)
                    .frame(width: 100, height: 134)

            } else {
                ProgressView()
                    .frame(width: 100, height: 134)
            }
                        
            VStack(alignment: .leading) {
                Text(viewModel.cast.name)
                    .lineLimit(nil)
                    .font(Font.Body.smallSemiBold)
                    .foregroundColor(Color.Text.charcoal)
                    .padding(.top,20)
                
            }
            Spacer()
        }
        .onAppear{
            Task {
                await self.viewModel.getImageURL()
            }
        }
    }
}

struct CastMovieCellView_Previews: PreviewProvider {
    static var previews: some View {
        CastMovieCellView(viewModel: .init(cast: .init(gender: 1, id: 6384, name: "Keanu Reeves", profilePath: "/4D0PpNI0kmP58hgrwGC3wCjxhnm.jpg", character: "John Wick")))
    }
}
