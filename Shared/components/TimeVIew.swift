//
//  TimeVIew.swift
//  Totel (iOS)
//
//  Created by Hatesh Kumar on 15/05/2023.
//

import SwiftUI


struct TimeView: View {
    
    var body: some View {
        
        HStack {
            Text("Time")
                .font(.system(size: 18, weight: .bold))
            Spacer()
          
            HStack {
                
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.black, lineWidth: 1)
                        .background(RoundedRectangle(cornerRadius: 20).foregroundColor(Color.white))
                    
                    Text("09:41")
                        .font(.system(size: 18, weight: .bold))
                }

                Button {

                } label: {
                    ZStack {
                        Circle()
                            .foregroundColor(Color("DarkWhite"))
                            .frame(width: 35, height: 35)
                        Image(systemName: "xmark")
                            .foregroundColor(Color("993C3C43"))
                            .font(.system(size: 17, weight: .bold))
                    }
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
        .frame(height:60)
        .padding(.horizontal)
    }
}
