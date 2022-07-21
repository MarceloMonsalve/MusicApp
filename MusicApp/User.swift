//
//  User.swift
//  MusicApp
//
//  Created by Marcelo Monsalve on 7/8/22.
//

import FirebaseFirestoreSwift
import Firebase

struct User: Identifiable, Decodable {
    let profileImageUrl: String
    let username: String
    let bio: String
    let fullname: String
    @DocumentID var id: String?
}
