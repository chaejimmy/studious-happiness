////
//  ReverseLabelStyle.swift
//  bug-free-goggles
//
//  Created by Mac on 03/05/23.
//

import SwiftUI

struct ReverseLabelStyle: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack(spacing: 4) {
            configuration.title
                .font(.circular(size: 17, weight: .medium))
                //.foregroundColor(.black)
            configuration.icon
        }
    }
}

struct ReverseLabelStyle_Previews: PreviewProvider {
    static var previews: some View {
        Label("Alex Norman", image: "tickIcon")
            .labelStyle(ReverseLabelStyle())
    }
}
