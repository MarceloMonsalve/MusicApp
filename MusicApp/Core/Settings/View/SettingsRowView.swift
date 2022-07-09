//
//  SideMenuRowView.swift
//  TwitterSwiftClonePractice
//
//  Created by Ricardo Gonzalez on 6/15/22.
//

import SwiftUI

struct SettingsRowView: View {
    let viewModel: SettingsViewModel
    
    var body: some View {
        HStack(spacing: 16 ) {
            Image(systemName: viewModel.imageName)
                .font(.title)
                .foregroundColor(.white)
            
            Text(viewModel.title)
                .foregroundColor(.white)
                .font(.title2)
                
            
            Spacer()
        }
        .frame(height: 40)
        .padding(.horizontal)
        .foregroundColor(.white)
        .background(.black)
    }
}

struct SettingsRowView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsRowView(viewModel: .edit)
    }
}
