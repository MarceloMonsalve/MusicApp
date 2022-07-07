////
////  SideMenuViewModel.swift
////  TwitterSwiftClonePractice
////
////  Created by Ricardo Gonzalez on 6/15/22.
////
//
enum SettingsViewModel: Int, CaseIterable {
    case edit
    case logout
    
    var title: String {
        switch self {
        case .edit: return "Edit Profile"
        case .logout: return "Logout"
        }
    }
    var imageName: String {
        switch self {
        case .edit: return "square.and.pencil"
        case .logout: return "arrow.left.square"
        }
    }
}
