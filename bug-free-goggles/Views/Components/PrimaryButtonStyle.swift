////
//  PrimaryButtonStyle.swift
//  bug-free-goggles
//
//  Created by Mac on 01/05/23.
//

import SwiftUI

struct PrimaryButtonStyle: ButtonStyle {
    var foregroundColor: Color = .white
    var background: Color = .lightIndigo
    var isDisable: Bool = false
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .font(.circular(size: 17, weight: .medium))
            .padding(.vertical, 14)
            .foregroundColor(isDisable ? .secondaryGray :foregroundColor)
            .background(isDisable ? .darkWhite : background)
            .clipShape(Capsule())
    }
}

struct FixedPaddingButtonStyle: ButtonStyle {
    var foregroundColor: Color = .white
    var background: Color = .appPrimary
    var isDisable: Bool = false
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.circular(size: 17, weight: .medium))
            .padding(.horizontal, 32)
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
            .font(.circular(size: 17, weight: .medium))
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

struct secondaryButtonStyle: ButtonStyle {
    var foregroundColor: Color = .white
    var background: Color = .appPrimary
    var isDisable: Bool = false
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.horizontal, 32)
            .padding(.vertical, 14)
            .font(.circular(size: 17, weight: .medium))
            .foregroundColor(isDisable ? .secondaryGray :foregroundColor)
            .background(isDisable ? .darkWhite : background)
            .clipShape(Capsule())
            .disabled(isDisable)
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
            
            Button {
                
            } label: {
                Text("Next")
            }
            .buttonStyle(secondaryButtonStyle())
            
            Button {
                
            } label: {
                Text("Next-Disabled")
            }
            .buttonStyle(secondaryButtonStyle(isDisable: true))
            
            Button {
                
            } label: {
                Text("Back")
            }
            .buttonStyle(secondaryButtonStyle(foregroundColor: .black, background: .secondaryLightGray))
            
        }.padding()
    }
}
