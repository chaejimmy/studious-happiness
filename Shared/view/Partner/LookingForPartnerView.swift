//
//  LookingForPartnerView.swift
//  Totel (iOS)
//
//  Created by Hatesh Kumar on 11/05/2023.
//


import SwiftUI

struct LookingForPartnerView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {

            TabView {
                PostImageItem(title: "frame1")
                PostImageItem(title: "frame2")
                PostImageItem(title: "frame3")
            }
            .tabViewStyle(.page)
            .frame(height: 255)
            
            VStack(alignment: .leading, spacing: 2) {

                HStack(alignment: .top, spacing: 12) {
                 
                
                    VStack(alignment: .leading, spacing: 2) {
                       
                        HStack {
                            
                            Label("Alex Norman", image: "tickIcon")
                                .labelStyle(ReverseLabelStyle())
                                .padding(.top,7)
                            
                            
                            Spacer()
                            Button {
                                
                            } label: {
                                Image("moreIcon")
                                    .resizable()
                                    .frame(width: 24, height: 24)
                            }
                        }
                        Text("Great Western Dockyard, Gas Ferry Rd, Bristol BS1 6TY")
                            .font(.system(size: 13, weight: .regular))
                            .foregroundColor(.secondaryGray)
                            .padding(.top,3)
                    }
                 
                }
                
                Text("Looking Places: Bristol, Bath & London")
                    .font(.system(size: 15))
                    .foregroundColor(.black)
                    .padding(.top,3)
                
                HStack {
                    Text("Available from ")
                        .font(.system(size: 13, weight: .regular))
                        .foregroundColor(.secondaryGray)
                   
                    Text("20th March, 2023")
                            .font(.system(size: 13, weight: .bold))
                            .foregroundColor(Color("993C3C43"))
                            .padding(.top,1)
                }
                
                HStack(spacing: 4) {
                    Text("Budget $650-$800")
                        .font(.system(size: 15, weight: .regular))
                    Spacer()
                    Text("Unavailable")
                        .font(.system(size: 13, weight: .regular))
                        .padding(.vertical, 4)
                        .padding(.horizontal, 12)
                        .foregroundColor(.secondaryGray)
                        .background(
                            Capsule()
                                .fill(Color.lightGray)
                        )
                }
                .padding(.top, 5)
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 12)
        .background(Color.white)
    }
}

struct PartnerImageItem: View {
    var title: String
    
    var body: some View {
        Image(title)
            .resizable()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}


struct LookingForPartner_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            LookingForPartnerView()
        }
    }
}
