//
//  AuthManager.swift
//  MusicApp
//
//  Created by Marcelo Monsalve on 7/7/22.
//

import SwiftUI
import Firebase

class AuthManager: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var tempSession: FirebaseAuth.User?
    @Published var currentUser: User?
    @Published var newUserVar = false
    
    private let service = UserService()
    
    init() {
        self.newUser { bool in
            if !bool{
                self.userSession = Auth.auth().currentUser
                self.fetchUser()
            } else {
                self.tempSession = Auth.auth().currentUser
                self.newUserVar = bool
            }
        }

//        self.signOut()
    }
    
    func createUser(username: String, fullname: String, bio: String = "", image: UIImage) {
        // if user doesnt finish signing up in old session
        guard let uid = self.tempSession?.uid else { return }
        Firestore.firestore().collection("users").document(uid).setData([
            "username": username.lowercased(),
            "fullname": fullname,
            "bio": bio,
        ]) { _ in
            self.uploadProfileImage(image)
        }
    }
    
    func updateUser(username: String, fullname: String, bio: String, image: UIImage, imageChanged: Bool, completion: @escaping() -> Void) {
        guard let uid = self.userSession?.uid else { return }
        Firestore.firestore().collection("users").document(uid).updateData([
            "username": username.lowercased(),
            "fullname": fullname,
            "bio": bio,
        ]) { _ in
            if imageChanged {
                self.updateProfileImage(image) {
                    completion()
                }
            }
        }
    }
    
    func updateUser(username: String, fullname: String, bio: String, completion: @escaping() -> Void) {
        guard let uid = self.userSession?.uid else { return }
        Firestore.firestore().collection("users").document(uid).updateData([
            "username": username.lowercased(),
            "fullname": fullname,
            "bio": bio,
        ]) { _ in
            self.fetchUser()
            completion()
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
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let docRef = Firestore.firestore().collection("users")
            .document(uid)
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                completion(false)
            } else {
                completion(true)
            }
        }
    }
    
    func uploadProfileImage(_ image: UIImage) {
        guard let uid = self.tempSession?.uid else { return }
        ImageUploader.uploadImage(image: image) { profileImageUrl in
            Firestore.firestore().collection("users")
                .document(uid)
                .updateData(["profileImageUrl": profileImageUrl]){ _ in
                    self.userSession = self.tempSession
                    self.fetchUser()
                }
        }
    }
    
    func updateProfileImage(_ image: UIImage, completion: @escaping() -> Void) {
        guard let uid = self.userSession?.uid else { return }
        ImageUploader.uploadImage(image: image) { profileImageUrl in
            Firestore.firestore().collection("users")
                .document(uid)
                .updateData(["profileImageUrl": profileImageUrl]){ _ in
                    self.fetchUser()
                    completion()
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
        self.userSession = nil
        self.newUserVar = false
        try? Auth.auth().signOut()
    }
}
