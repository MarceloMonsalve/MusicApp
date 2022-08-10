//
//  NewPostViewModel.swift
//  MusicApp
//
//  Created by Marcelo Monsalve on 7/5/22.
//

import Foundation

class NewPostViewModel: ObservableObject {
    @Published var linkText = ""
    @Published var validLink = false
    @Published var didUploadTweet = false
    let service = PostService()
    
    func previewLink() {
        //Check if link is valid then fetch information and change valid link to true.
        if linkText.isEmpty {
            validLink = false
        } else {
            validLink = true
        }
    }
    
    
    func post(withCaption caption: String) {
        service.uploadPost(caption: caption) { success in
            if success {
                self.didUploadTweet = true
            } else {
                print("Error Uploading tweet")
            }
        }
    }
}
