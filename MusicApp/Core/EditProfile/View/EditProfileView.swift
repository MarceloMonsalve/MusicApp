//
//  EditProfileView.swift
//  MusicApp
//
//  Created by Marcelo Monsalve on 7/5/22.
//

import SwiftUI

struct EditProfileView: View {
    var body: some View {
        VStack {
            Text("Cancel/Save")
            Text("Edit Profile")
                .font(.title).bold()
            Text("change profile photo")
            Text("change username")
            Text("Change name")
            Text("Change Bio")
            Text("Confirm")
        }

    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView()
    }
}
