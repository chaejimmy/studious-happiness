//
//  TextOverlay.swift
//  Totel
//
//  Created by Jaykrushna Solanki on 24/08/23.
//

import SwiftUI

struct TextOverlay: View {
    var title: String
    
    var gradient: LinearGradient {
        .init(
            gradient: Gradient(colors: [.black.opacity(0.6), .black.opacity(0)]),
            startPoint: .bottom,
            endPoint: .center)
    }
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            gradient
            Text(title)
                .font(.title)
                .bold()
            .padding()
        }
        .foregroundColor(.white)
    }
}


struct TextOverlay_Previews: PreviewProvider {
    static var previews: some View {
        TextOverlay(title: "Title")
    }
}
