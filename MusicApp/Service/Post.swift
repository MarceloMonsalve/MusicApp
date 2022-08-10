//
//  Post.swift
//  MusicApp
//
//  Created by Marcelo Monsalve on 7/22/22.
//

import FirebaseFirestoreSwift
import Firebase

struct Post: Identifiable, Decodable {
    @DocumentID var id: String?
    let caption: String
    let uid: String
    var likes: Int
    let timestamp: Timestamp
    
    var  user: User?
    var didLike: Bool? = false
}
