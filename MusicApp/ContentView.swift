//
//  ContentView.swift
//  MusicApp
//
//  Created by Marcelo Monsalve on 7/3/22.
//

import SwiftUI
import Firebase

struct ContentView: View {
    var body: some View {
        if Auth.auth().currentUser != nil {
          FeedView()
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
