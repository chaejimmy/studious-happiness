//
//  ReverseLabelStyle.swift
//  Totel (iOS)
//
//  Created by Hatesh Kumar on 11/05/2023.
//

import SwiftUI

struct ReverseLabelStyle: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack(spacing: 4) {
            configuration.title
                .font(.system(size: 16, weight: .semibold))
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
