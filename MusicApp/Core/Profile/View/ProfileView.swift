//
//  ProfileView.swift
//  MusicApp
//
//  Created by Marcelo Monsalve on 7/3/22.
//

import SwiftUI
import Kingfisher

struct ProfileView: View {
    @State private var selectedFilter: PostFilterViewModel = .posts
    @Namespace var animation
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: ProfileViewModel
    let authModel: AuthManager
    
    let thisUser: User
    
    @State private var showSettings = false
    
    init(user: User, model: AuthManager) {
        self.thisUser = user
        self.authModel = model
        self.viewModel = ProfileViewModel(user: user)
    }
    
    var body: some View {
        ZStack(alignment: .trailing) {
            VStack {
                headerView
            
                ScrollView{
                    LazyVStack {
                        statsView
                            .padding(.bottom)
                        filterBar
                            
                        postsView
                    }
                }
                .frame(maxHeight:.infinity)
            }
        
            if showSettings {
                settingsView
            }
            
            SettingsView(model: self.authModel, user: self.thisUser)
                .frame(width: 300)
                .offset(x: showSettings ? 0: 300, y: 0)
                .background(showSettings ? Color.background : Color.clear)
        }
        .foregroundColor(Color.text)
        .background(Color.background)
        .onAppear() {
            showSettings = false
        }
        .navigationBarHidden(true)
    }
}

extension ProfileView {
    
    var statsView: some View {
        VStack {
            VStack(spacing: 15) {
                KFImage(URL(string: viewModel.user.profileImageUrl))
                    .resizable()
                    .scaledToFill()
                    .clipShape(Circle())
                    .frame(width: 150, height: 150)
                    .padding()
        
                Text("@\(viewModel.user.username)")
                    .font(.title3).bold()
        
                if !viewModel.user.bio.isEmpty{
                    Text("\(viewModel.user.bio)")
                }
                
                HStack {
                    ProfileStatView(count: "28", what: "Following")
                    ProfileStatView(count: "837", what: "Followers")
                    ProfileStatView(count: "16.3K", what: "Likes")
                }
            }
        }
    }
    
    var headerView: some View {
        ZStack {
            Text("\(viewModel.user.fullname)")
                .font(.title3).bold()
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "arrow.left")
                        .foregroundColor(Color.icon)
                        .padding(.horizontal)
                        .font(.title2)
                }
                Spacer()
            }
            HStack {
                Spacer()
                Button {
                    withAnimation(.easeInOut) {
                        showSettings.toggle()
                    }
                } label: {
                    Image(systemName: "gearshape")
                        .foregroundColor(Color.icon)
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
                        .fontWeight(selectedFilter == item ? .bold : .regular)
                        .foregroundColor(selectedFilter == item ? .icon : .text)
                    if selectedFilter == item {
                        Capsule()
                            .foregroundColor(.text)
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
    
    var settingsView: some View {
        ZStack {
            Color(.black)
                .opacity(showSettings ? 0.35 : 0.0)
        }.onTapGesture {
            withAnimation(.easeInOut) {
                showSettings = false
            }
        }
        .ignoresSafeArea()
    }
}

//struct ProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileView()
//    }
//}

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
