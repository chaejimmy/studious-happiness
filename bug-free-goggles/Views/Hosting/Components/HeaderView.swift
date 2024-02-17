//
//  AddressTopView.swift
//  cheffy
//
//  Created by Viswanath Reddy on 08/05/23.
//

import SwiftUI

struct HeaderView: View {
    // MARK: - PROPERTIES
    var title: String
    var subTitle: String
    
    // MARK: - BODY
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .style(.title)
                .fixedSize(horizontal: false, vertical: true)
            
            Text(subTitle)
                .tracking(0.5)
                .style(.subheadline)
                .fixedSize(horizontal: false, vertical: true)
        }//: VSTACK
    }
}

struct AddressTopView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView(
            title: "Title",
            subTitle: "Sub Title"
        ).previewLayout(.sizeThatFits)
    }
}
