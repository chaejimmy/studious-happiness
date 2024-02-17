//
//  PersonPagesView.swift
//  Totel
//
//  Created by Jaykrushna Solanki on 24/08/23.
//

import SwiftUI

struct PersonPagesView: View {
    var body: some View {
        VStack {
            PageView(pages: PersonBio.dummy.map {
                PersonCard(bio: $0)
                    .aspectRatio(2 / 3, contentMode: .fit)
                    .frame(maxWidth: .infinity)
            })
            .padding()
        }

        
        
    }
}

struct PersonPagesView_Previews: PreviewProvider {
    static var previews: some View {
        PersonPagesView()
    }
}
