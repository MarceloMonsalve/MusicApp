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
    @StateObject var spotifyController = SpotifyController()
    
    var body: some View {
        Group {
            if (authModel.userSession != nil) {
                FeedView()
                    .onOpenURL { url in
                        spotifyController.setAccessToken(from: url)
                    }
                    .onReceive(NotificationCenter.default.publisher(for: UIApplication.didFinishLaunchingNotification), perform: { _ in
                        spotifyController.connect()
                    })
            } else {
                LoginView()
            }
        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
