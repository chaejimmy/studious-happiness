////
//  AddressDescribeView.swift
//  bug-free-goggles
//
//  Created by Mac on 09/05/23.
//

import SwiftUI
struct CardBackground: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(Color("CardBackground"))
            .cornerRadius(20)
            .shadow(color: Color.black.opacity(0.2), radius: 4)
    }
}
extension View {
    func cardBackground() -> some View {
        modifier(CardBackground())
    }
}
struct AddressDescribeView: View {
    
    // MARK: - PROPERTIES
    @Environment(\.presentationMode) var presentationMode
    @StateObject var addressDescribeVM = AddressDescribeViewModel()
    
    let rows = [
        GridItem(.adaptive(minimum: 140)),
        GridItem(.adaptive(minimum: 140))
    ]
    var hostingSelection: some View {
        HStack {
            VStack (alignment: .leading){
               Text("Totel your place")
                    .font(.subheadline)
                Text("It's simple to get setup and start earning")
            }
            Image("homeimage")
                .resizable()
                .frame(width: 100,height: 100)
        }
        .frame(width: 350, height: 100)
        .cornerRadius(20)
        .shadow(color: Color.pink.opacity(0.3), radius: 20, x: 0, y: 10)
        .shadow(color: Color.pink.opacity(0.2), radius: 5, x: 0, y: 2)
       
       
    }
    // MARK: - BODY
    var body: some View {
        // NavigationView {
        VStack(alignment: .leading, spacing: 20){
            // MARK: - HEADER
            HeaderView(title: .Hosting.describeAddressTitle, subTitle: .Hosting.describeAddressSubTitle)
            
            // MARK: - BODY
            AddressTypeContainerView(viewModel: addressDescribeVM)
           
            Spacer()
            
            // MARK: - FOOTER
            //back button
            HStack {
                //back button
                BottomBackButtonView {
                    presentationMode.wrappedValue.dismiss()
                }
                
                Spacer()
                
                // Next button
                NavigationLink {
                    SharableRoomDetailsView()
                } label: {
                    Text(String.Hosting.next)
                }
                .buttonStyle(secondaryButtonStyle(
                    isDisable: !addressDescribeVM.isSelected())
                )
                
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
            }//: TOOL BAR ITEM
            
        }//: TOOLBAR
        // }//: NAVIGATION VIEW
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .toolbarBackground(Color.background, for: .navigationBar)
        
    }//: BODY
}

struct AddressDescribe_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            AddressDescribeView()
        }
    }
}
