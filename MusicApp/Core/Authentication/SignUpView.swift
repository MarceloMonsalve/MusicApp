//
//  SignUpView.swift
//  MusicApp
//
//  Created by Marcelo Monsalve on 7/8/22.
//

import SwiftUI

struct SignUpView: View {
    @State var error = ""
    @State var username = ""
    @State var fullname = ""
    @State var bio = ""
    
    @State private var imageSelected = false
    @State private var showImagePicker = false
    @State private var selectedImage: UIImage?
    @State private var profileImage: Image?
    
    @EnvironmentObject var authModel: AuthManager

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
    }
}

//struct SignUpView_Previews: PreviewProvider {
//    static var previews: some View {
//        SignUpView()
//    }
//}

extension SignUpView {
    var headerView: some View {
        ZStack {
            Text("Create Profile")
                .font(.title2).bold()
            HStack(){
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
                    } else if imageSelected == false {
                        error = "No profile image selected"
                    } else {
                        error = ""
                        
                        authModel.checkUsername(username: username) { err in
                            if err.isEmpty {
                                guard let img = selectedImage else { return }
                                authModel.createUser(username: trimmedUsername,
                                                     fullname: trimmedName,
                                                     bio: trimmedBio,
                                                     image: img)
                            } else {
                                error = err
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
                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                        .renderingMode(.template)
                        .modifier(ProfileImageModifier())
                        .shadow(color: Color.text, radius: 2)
                }
            }
            .sheet(isPresented: $showImagePicker, onDismiss: loadImage) {
                ImagePicker(selectedImage: $selectedImage)
            }
        }
        .ignoresSafeArea()
    }
    
    func loadImage() {
        guard let selectedImage = selectedImage else { return }
        profileImage = Image(uiImage: selectedImage)
        imageSelected = true
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
