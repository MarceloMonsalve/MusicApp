//
//  MusicAppApp.swift
//  MusicApp
//
//  Created by Marcelo Monsalve on 7/3/22.
//

import SwiftUI
import FirebaseCore
import Firebase


@main
struct MusicAppApp: App {
    @StateObject var authModel = AuthManager()
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
                    .navigationBarHidden(true)
            }
            .environmentObject(authModel)
            
        }
    }
}
