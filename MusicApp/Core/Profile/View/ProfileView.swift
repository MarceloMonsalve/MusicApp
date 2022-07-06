//
//  ProfileView.swift
//  MusicApp
//
//  Created by Marcelo Monsalve on 7/3/22.
//

import SwiftUI

struct ProfileView: View {
    @State private var selectedFilter: PostFilterViewModel = .posts
    @Namespace var animation
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            headerView
            ScrollView{
                LazyVStack {
                    statsView
                    filterBar
                    postsView
                }
            }
            Spacer()
        }
        .foregroundColor(.white)
        .background(.black)
    }
}

extension ProfileView {
    var statsView: some View {
        VStack {
            VStack {
                Circle()
                    .frame(width: 100, height: 100)
                    .padding()
                Button {
                    
                } label: {
                    Text("Follow")
                        .font(.title3).bold()
                }
            }
            
            HStack {
                ProfileStatView(count: "28", what: "Following")
                ProfileStatView(count: "837", what: "Followers")
                ProfileStatView(count: "16.3K", what: "Likes")

            }
            .padding()
        }
    }
    var headerView: some View {
        ZStack {
            Text("Sasha Larson")
                .font(.title3).bold()
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "arrow.left")
                        .padding(.horizontal)
                        .font(.title2)
                }
                Spacer()
            }
            HStack {
                Spacer()
                NavigationLink {
                    SettingsView()
                        .navigationBarHidden(true)
                } label: {
                    Image(systemName: "gearshape")
                        .padding(.horizontal)
                        .font(.title2)
                }
                
            }
        }
    }
    
    var filterBar: some View {
        HStack {
            ForEach(PostFilterViewModel.allCases, id: \.rawValue) { item in
                VStack {
                    Text(item.title)
                        .font(.subheadline)
                        .fontWeight(selectedFilter == item ? .semibold : .regular)
                        .foregroundColor(selectedFilter == item ? .white : .gray)
                    if selectedFilter == item {
                        Capsule()
                            .foregroundColor(.white)
                            .frame(height: 2)
                            .matchedGeometryEffect(id: "filter", in: animation)
                        
                    } else {
                        Capsule()
                            .foregroundColor(Color(.clear))
                            .frame(height: 2)
                    }
                }
                .onTapGesture {
                    withAnimation(.easeInOut) {
                        self.selectedFilter = item
                    }
                }
            }
        }
        .overlay(Divider().offset(x: 0, y: 16))
    }
    
    var postsView: some View {
        ForEach(1...5, id: \.self) { _ in
            PostView()
        }
    }

}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

struct ProfileStatView: View {
    let count: String
    let what: String
    var body: some View {
        VStack {
            Text(count)
                .font(.headline)
            Text(what)
                .font(.subheadline)
        }
        .frame(width: 90)
    }
}
