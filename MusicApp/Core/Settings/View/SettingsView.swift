//
//  SettingsView.swift
//  MusicApp
//
//  Created by Marcelo Monsalve on 7/4/22.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack(alignment: .leading) {
            ZStack {
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
                Text("Settings")
                    .font(.title2).bold()
            }
            VStack(alignment: .leading) {
                Text("Notifications")
                Text("Spotify")
                Text("Logout")
                
            }
            .padding()
            
            Spacer()
        }
        .background(.black)
        .foregroundColor(.white)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
