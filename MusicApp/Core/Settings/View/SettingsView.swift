//
//  SettingsView.swift
//  MusicApp
//
//  Created by Marcelo Monsalve on 7/4/22.
//

import SwiftUI
//import Kingfisher

struct SettingsView: View {
//    @Environment(\.dismiss) var dismiss
//    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 32) {
            
            Text("Settings")
                .font(.largeTitle)
                .bold()
                .padding()

            ForEach(SettingsViewModel.allCases, id: \.rawValue) { settingsViewModel in
                if settingsViewModel == .edit {
                    NavigationLink {
                        EditProfileView()
                    } label: {
                        SettingsRowView(viewModel: settingsViewModel)
                    }
                
                } else if settingsViewModel == .logout {
                    Button {
//                        viewModel.signOut()
                    } label: {
                        SettingsRowView(viewModel: settingsViewModel)
                    }
                } else {
                    
                }
            }
            Spacer()
        }
        .padding()
        .background(.black)
        .foregroundColor(.white)
        
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}


