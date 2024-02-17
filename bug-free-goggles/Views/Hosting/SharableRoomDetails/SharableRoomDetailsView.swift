////
//  SharableRoomDetailsView.swift
//  bug-free-goggles
//
//  Created by Mac on 10/05/23.
//

import SwiftUI

struct SharableRoomDetailsView: View {
    
    // MARK: - PROPERTIES
    @StateObject var sharableRoomDetailsVM = SharableRoomDetailsViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    let rows = [
        GridItem(.adaptive(minimum: 140))
    ]
    
    @State var personsCount:Int = 1
    @State var bedroomsCount:Int = 1
    @State var bedsCount:Int = 1
    @State var bathroomsCount:Int = 1
    
    // MARK: - BODY
    var body: some View {
        // MARK: - TOP HEADER
        VStack(alignment: .leading, spacing: 10) {
            // MARK: - HEADER
            HeaderView(
                title: String.Hosting.whoWillshareTheRoomTitle,
                subTitle: String.Hosting.whoWillshareTheRoomSubTitle
            )
            
            // MARK: - Horizantal List
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHGrid(rows: rows, alignment: .center, spacing: 10) {
                    ForEach(sharableRoomDetailsVM.menuItems, id: \.id) { item in
                        
                        ChipView(title: item.title,
                                 imageName: item.imageName,
                                 bgColor: Color.appPrimary,
                                 isSelected: item.isselected) {
                            sharableRoomDetailsVM.updateSelected(selecteMenuItem: item)
                        }
                    }
                }
                .frame(height: 80)
            }
            
            Text(String.Hosting.sharableDetails)
                .style(.subheadline1)
            CounterView(lable: String.Hosting.persons){count in
                
            }
            //StepperRowView(title: String.Hosting.persons, stepValue: $personsCount, spacing: 10)
            
            Text(String.Hosting.sharableDetails).style(.subheadline1)
//            StepperRowView(title: String.Hosting.bedrooms, stepValue: $bedroomsCount, spacing: 10)
//            StepperRowView(title: String.Hosting.beds, stepValue: $bedsCount, spacing: 10)
//            StepperRowView(title: String.Hosting.bathrooms, stepValue: $bathroomsCount, spacing: 10)
            
            CounterView(lable: String.Hosting.bedrooms){count in
                
            }
            
            CounterView(lable: String.Hosting.beds){count in
                
            }
            
            CounterView(lable: String.Hosting.bathrooms){count in
                
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
                    AmenitiesDetailView()
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
                }//: TOOL BAR ITEM
            }//: TOOLBAR
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden()
            .toolbarBackground(Color.background, for: .navigationBar)
    }
}

struct SharableRoomDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        SharableRoomDetailsView()
    }
}
