//
//  EditProfileView.swift
//  MusicApp
//
//  Created by Marcelo Monsalve on 7/5/22.
//

import SwiftUI

struct EditProfileView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var fullname = "Sasha Larson"
    @State private var username = "sashalarson"
    @State private var bio = "Better music taste than you"
    
    @State private var showImagePicker = false
    @State private var selectedImage: UIImage?
    @State private var profileImage: Image?
    
    var body: some View {
        
        VStack {
            headerView.padding(.vertical)
//            HLine(color: Color.text, width: 1)
            pictureView
                .padding(.bottom)

            VStack {
                CustomInputField(imageName: "person",
                                 placeholderText: "Username",
                                 text: $username)
                .padding()
        
//                if username == "" {
//
//                    HStack{
//                        Text("Username error")
//                            .bold()
//                            .foregroundColor(Color(.systemRed))
//                            .padding(.leading)
//
//                        Spacer()
//                    }
//                }
                
                CustomInputField(imageName: "person",
                                 placeholderText: "Full Name",
                                 text: $fullname)
                .padding()

                CustomInputField(imageName: "highlighter",
                                 placeholderText: "Tell us about yourself...",
                                 text: $bio)
                .padding()
            }
            .padding(.horizontal, 32)
            .padding(.top)
            
            Spacer()
        }
        .background(Color.background)
        .foregroundColor(Color.text)
        .navigationBarHidden(true)
    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            EditProfileView()
            EditProfileView()
                .preferredColorScheme(.dark)
        }
    }
}

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
// somehow check if image is the same, try to delete old profile pics
//                    viewModel.uploadProfileImage(selectedImage)
                    
// check if username is valid and available
// https://stackoverflow.com/questions/47405774/cloud-firestore-enforcing-unique-user-names
                    
                } label: {
                    Text("Save")
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
