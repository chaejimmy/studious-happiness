//
//  MapButtons.swift
//  Totel (iOS)
//
//  Created by Alexander Boakye on 07/09/2023.
//

import SwiftUI

struct MapButtons: View {
    let image: String
    let system: Bool
    var body: some View {
        Group {
            if system {
                Image(systemName: image)
                    .resizable()
            } else {
                
                Image(image)
                    .resizable()
            }
        }
        .frame(width: 16, height: 16)
        .padding(8)
        .background(.white)
        .clipShape(Circle())
        .shadow(color: Color(red: 0.06, green: 0.09, blue: 0.16).opacity(0.1), radius: 1.5, x: 0, y: 1)
        .shadow(color: Color(red: 0.06, green: 0.09, blue: 0.16).opacity(0.1), radius: 1, x: 0, y: 1)
    }
}
