//
//  FeedView.swift
//  MusicApp
//
//  Created by Marcelo Monsalve on 7/3/22.
//

import SwiftUI

struct FeedView: View {
    var body: some View {
        VStack {
            ZStack {
                Text("JukeBox")
                    .font(.title)
                HStack {
                    NavigationLink {
                        SearchView()
                            .navigationBarHidden(true)
                    } label: {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.white)
                            .frame(width: 48, height: 48)
                    }
                    

                    NavigationLink {
                        NewPostView()
                            .navigationBarHidden(true)
                    } label: {
                        Image(systemName: "plus")
                            .foregroundColor(.white)
                            .frame(width: 48, height: 48)
                    }
                    


                    Spacer()
                    
                    Spacer()
                    NavigationLink {
                        ProfileView()
                            .navigationBarHidden(true)
                    } label: {
                        Circle()
                            .frame(width: 48, height: 48)
                    }


                }
                .padding(.horizontal)
            }
            HLine(color: .white, width: 1)
            ScrollView {
                LazyVStack {
                    ForEach(1...5, id: \.self) { _ in
                        PostView()
                    }
                }
            }
            Spacer()
            
        }
        .foregroundColor(.white)
        .background(.black)
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}
