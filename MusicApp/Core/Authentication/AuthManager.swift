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
    @Published var tempUser: Firebase.User?
    @Published var newUserVar = false
    
    
    init() {
        self.tempUser = Auth.auth().currentUser
        self.newUser { bool in self.newUserVar =  bool }
        self.userSession = Auth.auth().currentUser
    }
    
    func setUsername(username: String) {
        // Add a new document in collection "cities"
        Firestore.firestore().collection("users").document(tempUser!.uid).setData([
            "username": username.lowercased()
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
    }
    
    func validateUsername(str: String) -> Bool
    {
        do
        {
            let regex = try NSRegularExpression(pattern: "^[0-9a-zA-Z\\_]{1,18}$", options: .caseInsensitive)
            if regex.matches(in: str, options: [], range: NSMakeRange(0, str.count)).count > 0 {return true}
        }
        catch {}
        return false
    }
    
    func checkUsername(username: String, completion: @escaping(String) -> Void) {
        if !validateUsername(str: username) {
            completion("Username Invalid")
            return
        }
        Firestore.firestore().collection("users")
            .whereField("username", isEqualTo: username)
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    if querySnapshot!.isEmpty {
                        completion("")
                    } else {
                        completion("Username is  taken")
                    }
                }
        }
    }
    
    func newUser(completion: @escaping(Bool) -> Void) {
        guard let uid = self.tempUser?.uid else { return }
        
        let docRef = Firestore.firestore().collection("users")
            .document(uid)
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                completion(false)
                print("does exist")
            } else {
                completion(true)
                print("does not exist")
            }
        }
    }
    
    func fetchUser() {
        guard let uid = self.userSession?.uid else { return }
        service.fetchUser(withUid: uid) { user in
            self.currentUser = user
        }
    }

    func signOut() {
        userSession = nil
        try? Auth.auth().signOut()
    }
    
}
