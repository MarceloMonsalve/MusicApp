//
//  EditProfileView.swift
//  MusicApp
//
//  Created by Marcelo Monsalve on 7/5/22.
//

import SwiftUI
import Kingfisher

struct EditProfileView: View {
    @Environment(\.dismiss) var dismiss
    
    @State var error = ""
    @State var username: String
    @State var fullname: String
    @State var bio: String
    
    @State private var imageChanged = false
    @State private var showImagePicker = false
    @State private var selectedImage: UIImage?
    @State private var profileImage: Image?
    
    var currentUser: User?
    let authModel: AuthManager
    
    init(model: AuthManager, username: String, fullname: String, bio: String) {
        self.authModel = model
        
        _username = State(initialValue: username)
        _fullname = State(initialValue: fullname)
        _bio = State(initialValue: bio)
        
        if let user = self.authModel.currentUser{
            self.currentUser = user
        }
    }
    
    var body: some View {
        VStack {
            headerView
                .padding(.vertical)
            pictureView
                .padding(.bottom)
            fieldView
                .padding(.horizontal, 32)
                .padding(.top)
        }
        .background(Color.background)
        .foregroundColor(Color.text)
        .navigationBarHidden(true)
    }
}

//struct EditProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        Group {
//            EditProfileView()
//            EditProfileView()
//                .preferredColorScheme(.dark)
//        }
//    }
//}

extension EditProfileView {
    var headerView: some View {
        ZStack {
            Text("Edit Profile")
                .font(.title2).bold()
            HStack {
                Button {
                    dismiss()
                } label: {
                    Text("Cancel")
                        .padding(.horizontal)
                        .font(.title3)
                }
                Spacer()
                Button {
                    let trimmedUsername = username.trimmingCharacters(in: .whitespacesAndNewlines)
                    let trimmedName = fullname.trimmingCharacters(in: .whitespacesAndNewlines)
                    let trimmedBio = bio.trimmingCharacters(in: .whitespacesAndNewlines)
                    
                    if fullname.count > 20{
                        error = "Full name is too long"
                    } else if fullname.count == 0 {
                        error = "Full name is too short"
                    } else if bio.count > 180 {
                        error = "Bio is too long"
                    } else {
                        error = ""
                        
                        authModel.checkUsername(username: username) { err in
                            if err.isEmpty {
                                if !imageChanged{
                                    authModel.updateUser(username: trimmedUsername,
                                                         fullname: trimmedName,
                                                         bio: trimmedBio) {
                                        dismiss()
                                    }
                                } else{
                                    guard let img = selectedImage else { return }
                                    authModel.updateUser(username: trimmedUsername,
                                                         fullname: trimmedName,
                                                         bio: trimmedBio,
                                                         image: img,
                                                         imageChanged: imageChanged) {
                                        dismiss()
                                    }
                                }
                            } else {
                                error = err
                                if error == "Username is  taken" {
                                    if trimmedUsername == currentUser?.username{
                                        if !imageChanged{
                                            authModel.updateUser(username: trimmedUsername,
                                                                 fullname: trimmedName,
                                                                 bio: trimmedBio) {
                                                dismiss()
                                            }
                                        } else{
                                            guard let img = selectedImage else { return }
                                            authModel.updateUser(username: trimmedUsername,
                                                                 fullname: trimmedName,
                                                                 bio: trimmedBio,
                                                                 image: img,
                                                                 imageChanged: imageChanged) {
                                                dismiss()
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                } label: {
                    Text("Save")
                        .foregroundColor(Color.icon)
                        .padding(.horizontal)
                        .font(.title3)
                }
            }
        }
    }
    
    var pictureView: some View {
        VStack {
            Text("Change profile photo")
                .font(.title3)
                .padding(.top)
                
            Button {
                showImagePicker.toggle()
            } label: {
                if let profileImage = profileImage {
                    profileImage
                        .resizable()
                        .modifier(ProfileImageModifier())
                } else {
                    if let user = currentUser{
                        KFImage(URL(string: user.profileImageUrl))
                            .resizable()
                            .modifier(ProfileImageModifier())
                    }
                }
            }
            .sheet(isPresented: $showImagePicker,
                   onDismiss: loadImage) {
                ImagePicker(selectedImage: $selectedImage)
            }
        }
        .ignoresSafeArea()
    }
    
    func loadImage() {
        guard let selectedImage = selectedImage else { return }
        profileImage = Image(uiImage: selectedImage)
        imageChanged = true
    }
    
    var fieldView: some View {
        VStack {
            CustomInputField(imageName: "person",
                             placeholderText: "Username",
                             text: $username)
            .padding()
            
            CustomInputField(imageName: "person",
                             placeholderText: "Full name",
                             text: $fullname)
            .padding()

            CustomInputField(imageName: "highlighter",
                             placeholderText: "Tell us about yourself...",
                             text: $bio)
            .padding()
        
            Text(error)
                .foregroundColor(.red)
                .padding(4)

            Spacer()
        }
    }
}

private struct ProfileImageModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(Color.text)
            .scaledToFill()
            .frame(width: 180, height: 180)
            .clipShape(Circle())
    }
}
