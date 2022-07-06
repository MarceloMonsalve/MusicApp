//
//  PostFilterViewModel.swift
//  MusicApp
//
//  Created by Marcelo Monsalve on 7/4/22.
//

import Foundation

enum PostFilterViewModel: Int, CaseIterable {
    case posts
    case likes
    
    var title: String {
        switch self {
        case.posts: return "Posts"
        case.likes: return "Likes"
        }
    }
}
