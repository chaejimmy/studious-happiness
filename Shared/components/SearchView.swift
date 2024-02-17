//
//  SearchView.swift
//  Totel (iOS)
//
//  Created by Hatesh Kumar on 14/05/2023.
//


import SwiftUI

struct SearchWidget : View {
    @FocusState var searchFocused: Bool
    @State var searchAnimation: Bool = false
    @State private var searchText: String = ""
    var placeHolder: String

    var body: some View {
        
        HStack(spacing: 12) {
            Image("searchIcon")
                .frame(width: 24, height: 24)
            TextField(placeHolder, text: $searchText)
                .focused($searchFocused)
                .font(.system(size: 17, weight: .regular))
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.vertical, 14)
        .padding(.horizontal, 18)
        .background {
            Capsule()
                .fill(Color.lightGray)
                .overlay {
                    Capsule()
                        .stroke(style: StrokeStyle(lineWidth: searchAnimation ? 1 : 0))
                        .foregroundColor(.appPrimary)
                }
                .padding(.vertical, 0.5)
        }
    }
}
