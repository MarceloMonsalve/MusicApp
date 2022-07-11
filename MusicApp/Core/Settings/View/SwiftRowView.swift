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
                .foregroundColor(Color.icon)
            
            Text(viewModel.title)
                .font(.title2)
                
            
            Spacer()
        }
        .frame(height: 40)
        .padding(.horizontal)
    }
}

struct SettingsRowView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsRowView(viewModel: .edit)
    }
}
