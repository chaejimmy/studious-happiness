//
//  RoomItemWidget.swift
//  Totel (iOS)
//
//  Created by Hatesh Kumar on 14/05/2023.
//

import SwiftUI

struct RoomItemWidget : View {
    var title : String
    var index : String

    var body: some View {
        
        HStack(alignment: .center) {
            
            Text(title)
                .font(.system(size: 17, weight: .bold))
            
            
            Spacer()
            
            HStack(alignment: .center){
         
                Button {
                } label: {
                    Image(systemName: "minus")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 17, height: 17)
                        .foregroundColor(.black)
                        .padding()
                        .clipShape(Circle())
                        .foregroundColor(Color("272D37"))
                        .background(Color.white)
                        .overlay(
                            Circle()
                                .stroke(Color("DAE0E6"), lineWidth: 1)
                        )
                }
                
                Text(index)
                    .font(.system(size: 16, weight: .semibold))
                    .frame(width: 30)
                    .padding(.vertical, 11)
                
                Button {
                } label: {
                    Image(systemName: "plus")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 17, height: 17)
                        .foregroundColor(.black)
                        .padding()
                        .clipShape(Circle())
                        .foregroundColor(Color("272D37"))
                        .background(Color.white)
                        .overlay(
                            Circle()
                                .stroke(Color("DAE0E6"), lineWidth: 1)
                        )
                }
                .padding(.trailing,20)
                
            }

                        
        }
        .padding(.top,10)
        .padding(.leading,5)

    }
    
}


