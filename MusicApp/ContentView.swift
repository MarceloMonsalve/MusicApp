//
//  ContentView.swift
//  MusicApp
//
//  Created by Marcelo Monsalve on 7/3/22.
//

import SwiftUI
import Firebase

struct ContentView: View {
    @EnvironmentObject var authModel: AuthManager
    
    var body: some View {
        if authModel.userSession != nil {
            if authModel.newUserVar {
                SignUpView()
            } else {
                FeedView()
            }
        } else {
            LoginView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
