//
//  AddressAnnotationView.swift
//  cheffy
//
//  Created by Viswanath Reddy on 08/05/23.
//

import SwiftUI

struct AddressAnnotationView: View {
    // MARK: - PROPERTIES
    @State private var showTitle = true
    let title: String
    
    // MARK: - BODY
    var body: some View {
        VStack(spacing: 0) {
            Text(title)
                .lineLimit(nil)
                .font(.callout)
                .padding(5)
                .background(Color(.white))
                .cornerRadius(10)
                .opacity(showTitle ? 0 : 1)
            
            Image(systemName: "mappin.circle.fill")
                .font(.title)
                .foregroundColor(.red)
            
            Image(systemName: "arrowtriangle.down.fill")
                .font(.caption)
                .foregroundColor(.red)
                .offset(x: 0, y: -5)
        }//: VSTACK
        .onTapGesture {
            withAnimation(.easeInOut) {
                showTitle.toggle()
            }
        }
    }
}

struct PlaceAnnotationView_Previews: PreviewProvider {
    static var previews: some View {
        AddressAnnotationView(title: "Place")
    }
}
