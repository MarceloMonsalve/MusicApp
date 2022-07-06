//
//  ContentView.swift
//  MusicApp
//
//  Created by Marcelo Monsalve on 7/3/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        FeedView()
            .navigationBarHidden(true)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
