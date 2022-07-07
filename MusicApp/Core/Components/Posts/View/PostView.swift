//
//  PostView.swift
//  MusicApp
//
//  Created by Marcelo Monsalve on 7/3/22.
//

import SwiftUI

struct PostView: View {
    let screenSize: CGRect = UIScreen.main.bounds
    var body: some View {
            VStack(alignment: .leading) {
                HStack {
                    Text("kayla")
                        .font(.headline)
                    Spacer()
                    Text("San Francisco, CA")
                        .italic()
                }
                .padding(.bottom, 4)
                Rectangle()
                    .aspectRatio(1, contentMode: .fit)
                HStack {
                    HLine(color: .white, width: 2)
                        .font(.title)
                        .frame(width: screenSize.size.width * 0.6)
                    Spacer()
                    Image(systemName: "heart")
                        .font(.title2)
                        .padding(.horizontal, 4)
                    Image(systemName: "repeat")
                        .font(.title2)
                }
                .padding(.vertical,5)
                Text("Comments (12)")
                    .font(.headline)
                Text("")
                    .padding(.vertical)
            }
            .foregroundColor(.white)
            .padding(20)
            .background(.black)

        }
            
        
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        PostView()
    }
}
