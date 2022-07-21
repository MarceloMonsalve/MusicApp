//
//  UserService.swift
//  MusicApp
//
//  Created by Marcelo Monsalve on 7/9/22.
//

import Firebase
import FirebaseFirestoreSwift

struct UserService {
    func fetchUser(withUid uid: String, completion: @escaping(User) -> Void) {
        Firestore.firestore().collection("users")
            .document(uid)
            .getDocument { snapshot, err in
                if let err = err {
                    print("Error getting documents: \(err.localizedDescription)")
                }
                guard let snapshot = snapshot else { return }
                guard let user = try? snapshot.data(as: User.self) else { return }
                completion(user)
            }
    }
}
