//
//  ChipView.swift
//  Totel (iOS)
//
//  Created by Hatesh Kumar on 08/05/2023.
//

import SwiftUI

struct ChipView: View {
    let title: String
    var bgColor: Color = .black
    var unBgColor: Color = .lightGray
    var unSelectedTextCoor: Color = .black
    var isSelected: Bool
    var showImage: Bool = false
    var imagePath: String = ""
    let action: () -> Void
    
    
    var body: some View {
        
        if showImage{
            
            HStack {
                
                
                SVGImage(name: imagePath, color: isSelected ? .white :unSelectedTextCoor)
                  
                
                Button {
                    action()
                } label: {
                    Text(title)
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundColor(isSelected ? .white : unSelectedTextCoor)
                }
                
                
            }
            .padding(.horizontal)
            .padding(.vertical, 10)

            .background(
                Capsule()
                    .fill(isSelected ? bgColor : unBgColor)
            )

            
        }else{
            Button {
                action()
            } label: {
                Text(title)
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundColor(isSelected ? .white : unSelectedTextCoor)
                    .padding(.horizontal)
                    .padding(.vertical, 10)
                    .background(
                        Capsule()
                            .fill(isSelected ? bgColor : unBgColor)
                    )
            }
        }
        
      
    }
}

struct ChipView_Previews: PreviewProvider {
    static var previews: some View {
        ChipView(title: GenderType.male.title, isSelected: true){}
    }
}
struct SVGImage: View {
    let name: String
    let color: Color
    
    var body: some View {
        Image(name)
        
            .renderingMode(.template)
            .foregroundColor(color)
            .frame(width: 20, height: 20)
    }
}
