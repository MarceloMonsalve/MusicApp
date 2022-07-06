//
//  HLine.swift
//  MusicApp
//
//  Created by Marcelo Monsalve on 7/3/22.
//

import SwiftUI

struct HLine: View {
    let color: Color
    let width: CGFloat
    
    var body: some View {
        HStack {
            Spacer()
        }
        .padding(0)
        .frame(minHeight: width)
        .background(color)
    }
}

//struct HLine_Previews: PreviewProvider {
//    static var previews: some View {
//        HLine()
//    }
//}
