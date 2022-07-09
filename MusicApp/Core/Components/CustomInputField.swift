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
                    .foregroundStyle(Color.icon, .primary)
                if isSecureField ?? false {
                    SecureField(placeholderText, text: $text)
                } else {
                    TextField(placeholderText, text: $text)
                }
            }
            HLine(color: Color.text, width: 1)
        }
    }
}

struct CustomInputField_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CustomInputField(imageName: "envelope",
                             placeholderText: "Email",
                             isSecureField: false,
                             text: .constant("")
            )
            .preferredColorScheme(.light)
            CustomInputField(imageName: "envelope",
                             placeholderText: "Email",
                             isSecureField: false,
                             text: .constant("")
            )
            .preferredColorScheme(.dark)
        }
    }
}
