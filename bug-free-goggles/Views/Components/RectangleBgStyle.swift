////
//  RectangleBgStyle.swift
//  bug-free-goggles
//
//  Created by Mac on 09/05/23.
//

import SwiftUI

struct RectangleBgStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.horizontal)
            .padding(.vertical, 14)
            .background(
                Rectangle()
                    .fill(Color.lightGray)
                
            )
            .cornerRadius(10)
    }
}

extension View {
    func rectangleBgStyle() -> some View {
        modifier(RectangleBgStyle())
    }
}
