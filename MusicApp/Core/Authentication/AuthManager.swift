//
//  AuthManager.swift
//  MusicApp
//
//  Created by Marcelo Monsalve on 7/7/22.
//

import Foundation
import Firebase

class AuthManager: ObservableObject {
    @Published var userSession: Firebase.User?
    
    init() {
        self.userSession = Auth.auth().currentUser
    }
    
    func signOut() {
        userSession = nil
        try? Auth.auth().signOut()
    }
}
