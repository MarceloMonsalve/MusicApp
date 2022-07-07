//
//  CustomInputField.swift
//  TwitterSwiftClonePractice
//
//  Created by Ricardo Gonzalez on 6/15/22.
//

import SwiftUI

struct CustomInputField: View {
    let imageName: String
    let placeholderText: String
    var isSecureField: Bool? = false
    @Binding var text: String
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                if isSecureField ?? false {
                    SecureField(placeholderText, text: $text)
                        .foregroundColor(.white)
                } else {
                    TextField(placeholderText, text: $text)
                        .foregroundColor(.white)
                }
                
            }
            Divider()
                .foregroundColor(.white)
                .background(.white)
        }
        .foregroundColor(.white)
        .background(.black)
    }
}

struct CustomInputField_Previews: PreviewProvider {
    static var previews: some View {
        CustomInputField(imageName: "envelope",
                         placeholderText: "Email",
                         isSecureField: false,
                         text: .constant("")
        )
    }
}
