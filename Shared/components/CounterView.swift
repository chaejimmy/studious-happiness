//
//  CounterView.swift
//  Totel (iOS)
//
//  Created by Hatesh Kumar on 13/05/2023.
//

import SwiftUI



struct CounterWidget: View {
    @State private var count = 5
    
    var body: some View {
        HStack(alignment: .center){
     
            Button {
                self.count -= 5
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

            Spacer() // Add spacer to distribute the space evenly
            
            Text("USD $\(count).00 / Per Day")
                .font(.system(size: 16, weight: .semibold))
                .frame(width: 230)
                .padding(.vertical, 11)

                .background(
                    RoundedRectangle(cornerRadius: 30)
                        .fill(Color.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 30)
                                .stroke(Color("DAE0E6"), lineWidth: 1) // Set the border color and width
                        )
                )
            
            Spacer()
            
            Button {
                self.count += 5
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
}

