//
//  RatingsView.swift
//  Totel (iOS)
//
//  Created by Alexander Boakye on 06/09/2023.
//

import SwiftUI

struct RatingsView: View {
    let rating: Double
    var body: some View {
        HStack {
            ForEach(0...4, id: \.self){ i in
                 Image(systemName: "star.fill")
                    .foregroundStyle(i <= Int(floor(rating)) ? .yellow : .gray)
                    .font(.subheadline)
            }
            Text(String(format: "(%.1f)", rating))
                .font(.subheadline)
        }
    }
}
