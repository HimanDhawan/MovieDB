//
//  AppErrorView.swift
//  MovieDB
//
//  Created by Himan Dhawan on 4/2/23.
//

import SwiftUI

struct AppErrorView: View {
    
    let message : String
    let image : Image = Image("error")

    var callRetry: (() -> Void)?
    
    var body: some View {
        VStack {
            image
            Text(message)
                .font(Font.Heading.medium)
                .fontWeight(.semibold)
            
            Button {
                self.callRetry?()
            } label: {
                Text("Retry")
                    .foregroundColor(Color.Text.systemBlack)
                    .fontWeight(.heavy)
                    .frame(width: 150 , height: 50, alignment: .center)
                    .background(Color.Text.errorButtonColor)
                    .cornerRadius(10)
                    .shadow(color: Color.Text.grey, radius: 6,y:5)
            }

        }
    }
}

struct AppErrorView_Previews: PreviewProvider {
    static var previews: some View {
        AppErrorView(message: "Server error")
    }
}
