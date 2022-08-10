//
//  NewPostView.swift
//  MusicApp
//
//  Created by Marcelo Monsalve on 7/4/22.
//

import SwiftUI

struct NewPostView: View {
    @ObservedObject var viewModel = NewPostViewModel()
    @Environment(\.dismiss) var dismiss
    let screenSize: CGRect = UIScreen.main.bounds
    var body: some View {
        VStack {
            HStack {
                Button {
                    dismiss()
                } label: {
                    Text("Cancel")
                }
                Spacer()
                Text("Post")
                    .bold()
            }
            .padding()
            spotifyLink
            if viewModel.validLink {
                postPreview
            } else {
                Spacer()
                Text("Enter a Spotify Song Link")
                    .padding(.bottom, 100)
            }
            

            Spacer()
            
        }
        .foregroundColor(Color.text)
        .background(Color.background)
    }
}

extension NewPostView {
    var spotifyLink: some View {
        HStack {
            TextField("", text: $viewModel.linkText)
                .onSubmit {
                    viewModel.previewLink()
                }
                .foregroundColor(Color.text)
                .padding()
                .padding(.horizontal, 24)
                .overlay(
                    HStack {
                        Image(systemName: "link")
                            .foregroundColor(Color.icon)
                            .frame(minWidth: 0,
                                   maxWidth: .infinity,
                                   alignment: .leading)
                            .padding(.leading, 8)
                    }
                )



        }
        .padding(.horizontal, 4)
    }
    
    var postPreview: some View {
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
                .padding(.bottom,50)
            Text("How I Get Myself Killed")
                .font(.title2).bold()
            Text("Indigo De Souza")
            
        }
        .padding(20)

    }
}

struct NewPostView_Previews: PreviewProvider {
    static var previews: some View {
        NewPostView()
    }
}
