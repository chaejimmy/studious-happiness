//
//  PrimaryButtonStyle.swift
//  Totel (iOS)
//
//  Created by Hatesh Kumar on 08/05/2023.
//

import SwiftUI

struct PrimaryButtonStyle: ButtonStyle {
    var foregroundColor: Color = .white
    var background: Color = .appPrimary
    var isDisable: Bool = false
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .font(.system(size: 17, weight: .semibold))
            .padding(.vertical, 14)
            .foregroundColor(isDisable ? .secondaryGray :foregroundColor)
            .background(isDisable ? .darkWhite : background)
            .clipShape(Capsule())
    }
}


struct BorderedButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .font(.system(size: 17, weight: .semibold))
            .padding(.vertical, 14)
            .foregroundColor(.black)
            .clipShape(Capsule())
            .background(
                Color.primaryGray
                    .opacity(0.2),
                in: Capsule().stroke()
            )
            .contentShape(Rectangle())
    }
}

struct PrimaryButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Button {
                
            } label: {
                Text("Sign In")
            }
            .buttonStyle(BorderedButtonStyle())
            Button {
                
            } label: {
                Text("Sign In")
            }
            .buttonStyle(PrimaryButtonStyle())
        }.padding()
    }
}
