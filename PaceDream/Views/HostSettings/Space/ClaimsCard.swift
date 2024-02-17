//
//  ClaimsCard.swift
//  Totel (iOS)
//
//  Created by Alexander Boakye on 06/09/2023.
//

import SwiftUI

struct ClaimsCard: View {
    let claim: ClaimsModel
    
    var body: some View {
        VStack {
            HStack(alignment: .center) {
                Image(claim.claimImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 130, height: 110)
                
                VStack(alignment: .leading) {
                    Text(claim.claimName)
                        .bold()
                        .padding(.bottom, 2)
                    
                    Text(claim.claimDescription)
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                        .lineLimit(3)
                        .padding(.bottom, 2)
                        Text(String(format: "Charges %.0f$", claim.price))
                            .font(.callout.bold())
                }
            }
            .padding(.bottom, 2)
            
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(.white)
                .shadow(color: .black.opacity(0.05), radius: 10, x: 4, y: 10)
                .shadow(color: .black.opacity(0.05), radius: 10, x: -4, y: -10)
            
        )
    }
}
