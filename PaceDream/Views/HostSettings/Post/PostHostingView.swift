//
//  PostHostingView.swift
//  Totel (iOS)
//
//  Created by Alexander Boakye on 07/09/2023.
//

import SwiftUI

struct PostHostingView: View {
    @State private var location = ""
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 10, height: 10)
                        .foregroundColor(.black)
                        .padding()
                        .background(Color("DarkWhite"))
                        .clipShape(Circle())
                }
                
                Text("Where's your place located?")
                    .font(.title.bold())
                    .padding(.bottom)
                
                Text("In this step, we'll ask you which type of stays you have and if guests will book the entire place or just a room.")
                    .padding(.bottom)
                
                VStack(alignment: .center, spacing: 20) {
                    TextField("", text: $location)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 100)
                                .fill(Color(red: 0.95, green: 0.95, blue: 0.97))
                        )
                        .overlay(alignment: .leading) {
                            HStack {
                                Image("location_on")
                                Text("enter location")
                            }
                            .padding()
                        }
                    
                    ZStack(alignment: .trailing){
                        //GoogleMapView()
                        VStack(alignment: .trailing){
                            MapButtons(image: "maximize", system: false)
                            Spacer()
                            HStack(spacing: 8) {
                                MapButtons(image: "plus.magnifyingglass", system: true)
                                MapButtons(image: "minus.magnifyingglass", system: true)
                            }
                        }
                        .padding()
                    }
                    .frame(width: UIScreen.main.bounds.width - 50, height: 350, alignment: .trailing)
                    .overlay(
                        RoundedRectangle(cornerRadius: 25)
                            .stroke(Color(.lightGray).opacity(0.4))
                    )
                }
                
                Spacer()
                
                HStack{
                    Button {
                        
                    } label: {
                        Text("Back")
                            .fontWeight(.semibold)
                            .foregroundColor(.black)
                    }
                    .padding(.horizontal, 32)
                    .padding(.vertical, 14)
                    .background(Color(red: 0.95, green: 0.95, blue: 0.97))
                    .cornerRadius(100)
                    
                    Spacer()
                    
                    Button {
                        
                    } label: {
                        Text("Next")
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                    }
                    .padding(.horizontal, 32)
                    .padding(.vertical, 14)
                    .background(Color.appBlue)
                    .cornerRadius(100)
                    
                }
                
            }
            .padding(.horizontal)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        }
    }
}
