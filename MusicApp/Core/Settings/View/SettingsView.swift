//
//  SettingsView.swift
//  MusicApp
//
//  Created by Marcelo Monsalve on 7/4/22.
//

import SwiftUI

struct SettingsView: View {
//    @Environment(\.dismiss) var dismiss
    let authModel: AuthManager
    let thisUser: User
    
    init(model: AuthManager, user: User) {
        self.thisUser = user
        self.authModel = model
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 32) {
            
            Text("Settings")
                .font(.largeTitle)
                .bold()
                .padding()

            ForEach(SettingsViewModel.allCases, id: \.rawValue) { settingsViewModel in
                if settingsViewModel == .edit {
                    NavigationLink {
                        EditProfileView(model: authModel,
                                        username: self.thisUser.username,
                                        fullname: self.thisUser.fullname,
                                        bio: self.thisUser.bio)
                    } label: {
                        SettingsRowView(viewModel: settingsViewModel)
                    }
                    .environmentObject(authModel)
                } else if settingsViewModel == .logout {
                    Button {
                        authModel.signOut()
                    } label: {
                        SettingsRowView(viewModel: settingsViewModel)
                    }
                } else {
                    
                }
            }
            Spacer()
        }
        .padding()
        .background(Color.background)
        .foregroundColor(Color.text)
    }
}

//struct SettingsView_Previews: PreviewProvider {
//    static var previews: some View {
//        SettingsView()
//    }
//}


