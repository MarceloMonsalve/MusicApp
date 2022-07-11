//
//  SignUpView.swift
//  MusicApp
//
//  Created by Marcelo Monsalve on 7/8/22.
//

import SwiftUI

struct SignUpView: View {
    @State var usernameCreated = false
    @State var error = ""
    @State var username = ""
    @EnvironmentObject var authModel: AuthManager

    var body: some View {
        VStack {
            NavigationLink(destination: FeedView().navigationBarHidden(true),
                           isActive: $usernameCreated,
                           label: { })
            Spacer()
            HStack {
                Spacer()
                ZStack(alignment: .leading) {
                    TextField("", text: $username)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .frame(height: 50)
                    Text("Username")
                        .shadow(color: .white, radius: 2, x: 0, y: 0)
                        .opacity(username.isEmpty ? 0.65 : 0)
                }
                Spacer()
            }
            .cornerRadius(3)
            .padding(.horizontal,50)
            
            
            Button {
                error = ""
                authModel.checkUsername(username: username) { err in
                    if err.isEmpty {
                        usernameCreated = true
                        authModel.createUser(username: username)
                    } else {
                        error = err
                    }
                }
            } label: {
                Text("Continue")
                    .shadow(color: .white, radius: 1, x: 0, y: 0)
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(width: 120, height: 40)
                    .background(.black)
                    .cornerRadius(7)
                    .padding()
            }
            .shadow(color: .white, radius: 3, x: 0, y: 0)

            Text(error)
                .opacity(0.8)
                .shadow(color: .white, radius: 1, x: 0, y: 0)
                .padding(4)


            

            Spacer()
        }
        .background(.black)
        .foregroundColor(.white)
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}



