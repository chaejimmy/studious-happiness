////
//  GiveATitleView.swift
//  bug-free-goggles
//
//  Created by Mac on 13/05/23.
//

import SwiftUI

struct GiveATitleView: View {
    // MARK: - PROPERTIES
    @State var heading:String = "House Ariena, United Kingdom"
    @State var note:String = "You'll have a great time at this comfortable place to stay."
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        // MARK: - TOP HEADER
        VStack(alignment: .leading, spacing: 20){
            // MARK: - HEADER
            HeaderView(
                title: String.Hosting.giveATitlePageTitle,
                subTitle: String.Hosting.giveATitlePageSubTitle
            )
            VStack(alignment: .leading, spacing: 10){
                Text("Heading").style(.subheadline1)
                TextField("", text: $heading)
                    .style(.subheadline)
                    .frame(height: 50)
                    .padding(.horizontal, 10)
                    .cornerRadius(20)
                    .background(Color.secondaryLightGray)
            }
            
            VStack(alignment: .leading, spacing: 10){
                Text("Note").style(.subheadline1)
                
                TextField("", text: $note,  axis: .vertical)
                    .style(.subheadline)
                    .multilineTextAlignment(.leading)
                    .lineLimit(nil)
                    .lineSpacing(2)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 10)
                    .cornerRadius(20)
                    .background(Color.secondaryLightGray)
            }
            
            Spacer()
            
            // MARK: - BOTTOM VIEW
            HStack {
                //Back button
                BottomBackButtonView {
                    presentationMode.wrappedValue.dismiss()
                }
                
                Spacer()
                
                // Next button
                NavigationLink {
                    GiveYourAvailability()
                } label: {
                    Text(String.Hosting.next)
                }
                .buttonStyle(secondaryButtonStyle())
                
            }//: HSTACK
            .padding(.bottom, 20)
        }
        .padding([.top, .horizontal], 16)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                CircleButton(size: 40, backgroundColor: .darkWhite) {
                    IconView(image: "chevron_left", size: 24)
                } action: {
                    presentationMode.wrappedValue.dismiss()
                }
            } }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .toolbarBackground(Color.background, for: .navigationBar)
    }
}

struct GiveATitleView_Previews: PreviewProvider {
    static var previews: some View {
        GiveATitleView()
    }
}
