//
//  User.swift
//  MusicApp
//
//  Created by Marcelo Monsalve on 7/8/22.
//

import FirebaseFirestoreSwift
import Firebase

struct User: Identifiable, Decodable {
    @DocumentID var id: String?
    let username: String
    let fullname: String
    let profileImageUrl: String
    var isCurrentUser: Bool { return Auth.auth().currentUser?.uid == id }
}
