////
//  NameAddressView.swift
//  bug-free-goggles
//
//  Created by Mac on 11/05/23.
//

import SwiftUI

struct NameAddressView: View {
    let name: String
    let address: String
    var isVerified: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(name)
                    .font(.system(size: 17, weight: .semibold))
                if isVerified {
                    Image("whiteTickIcon")
                        .foregroundColor(.white)
                }
                 Spacer()
            }
            
            Text(address)
                .font(.system(size: 17, weight: .regular))
        }
        .foregroundColor(.white)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color.appPrimary)
    }
}

struct NameAddressView_Previews: PreviewProvider {
    static var previews: some View {
        NameAddressView(
            name: "Hotel Huntington",
            address: "1200 E Huntington Dr,, Los Angeles County, California, Duarte, United States"
        )
    }
}
