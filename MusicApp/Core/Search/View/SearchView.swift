//
//  SearchView.swift
//  MusicApp
//
//  Created by Marcelo Monsalve on 7/5/22.
//

import SwiftUI

struct SearchView: View {
    @ObservedObject var viewModel = SearchViewModel()
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack(alignment: .leading) {
            searchBar
            HLine(color: .white, width: 1)

            Spacer()
        }
        .foregroundColor(.white)
        .background(.black)
        
    }
}

extension SearchView {
    var searchBar: some View {
        HStack {
            TextField("", text: $viewModel.searchText)
                .foregroundColor(.white)
                .padding(8)
                .padding(.horizontal, 24)
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.white)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    }
                )
            Button {
                dismiss()
            } label: {
                Text("Cancel")
            }


        }
        .padding(.horizontal)
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
