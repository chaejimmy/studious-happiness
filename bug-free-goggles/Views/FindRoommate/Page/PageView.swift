//
//  PageView.swift
//  Totel
//
//  Created by Jaykrushna Solanki on 24/08/23.
//

import SwiftUI

struct PageView<Page: View>: View {
    var pages: [Page]
    @State private var currentPage = 0
    
    var body: some View {
        ZStack(alignment: .top) {
            PageViewController(pages: pages, currentPage: $currentPage)
            PageControl(numberOfPages: pages.count, currentPage: $currentPage)
                .frame(width: CGFloat(pages.count * 18))
                .padding(.top)
        }
    }
}

struct PageView_Previews: PreviewProvider {
    static var previews: some View {
        PageView(pages: PersonBio.dummy.map {
            PersonCard(bio: $0)
                .aspectRatio(9 / 16, contentMode: .fill)
        })
    }
}
