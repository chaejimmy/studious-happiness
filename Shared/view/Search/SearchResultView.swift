//
//  SearchResultView.swift
//  Totel (iOS)
//
//  Created by Hatesh Kumar on 11/05/2023.
//

import SwiftUI

struct SearchResultView: View {
    @State var recentSeaches: [String] = [
        "Plaza hotel, CA, United States",
        "Platinum hotel, CA, United States",
        "Premier Inc, Bristol, United Kingdom"
    ]
    let searchAction: (String) -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Recent")
                .font(.system(size: 17, weight: .semibold))
            
            ForEach(recentSeaches.indices, id: \.self) { i in
                SearchItemView(
                    title: recentSeaches[i],
                    search: {
                        searchAction(recentSeaches[i])
                    }
                ) {
                    recentSeaches.remove(at: i)
                }
            }
            Spacer()
        }
        .padding(16)
    }
}

struct SearchItemView: View {
    let title: String
    let search: () -> Void
    let deleteSearch: () -> Void
    
    var body: some View {
        HStack {
            Text(title)
                .font(.system(size: 17, weight: .regular))
                .onTapGesture { search() }
            Spacer()
            Button {
                deleteSearch()
            } label: {
                Image(systemName: "xmark")
                    .resizable()
                    .frame(width: 10, height: 10)
                    .padding(8)
                    .foregroundColor(.black)
                    .background(Color.lightGray)
                    .clipShape(Circle())
            }

        }
    }
}

struct SearchResultView_Previews: PreviewProvider {
    static var previews: some View {
        SearchResultView(){ _ in }
    }
}
