////
//  SelectCheckoutOffers.swift
//  bug-free-goggles
//
//  Created by Mac on 12/07/2023.
//

import SwiftUI

struct SelectCheckoutOffers: View {
    @Environment(\.presentationMode) var presentationMode
    @State var allowEarlyCheckIn = false
    @State var allowLateCheckOut = false
    @State private var showSheet = false
    @State var dates: Set<DateComponents> = []

    var today: String {
        let today = Date.now
        let formatter1 = DateFormatter()
        formatter1.dateStyle = .short
        return formatter1.string(from: today)
    }
    var timeFrom: String {
        let today = Date.now
        let formatter1 = DateFormatter()
        formatter1.timeStyle = .short
        return formatter1.string(from: today)
    }
    
    var timeTo: String {
        let today = Date.now
        let formatter1 = DateFormatter()
        formatter1.timeStyle = .short
        return formatter1.string(from: today)
    }
    @State var percentageAdded = 30
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20){
            
                // MARK: - HEADER
                HeaderView(
                    title: "Tell us your check-in offers",
                    subTitle: "In this step, we would like to ask if you allow early check-in and late check-out, and if so, with their associated percentage fee."
                )
            ScrollView(showsIndicators: false) {
                // "In this step, we would like to ask if you allow early check-in and late check-out, and if so, with their associated percentage fee."
                VStack(alignment: .leading, spacing: 10) {
                    Toggle(isOn: $allowEarlyCheckIn) {
                        Text("Allow Early Check-in")
                            .font(.title2)
                            .fontWeight(.semibold)
                    }
                    
                    if allowEarlyCheckIn {
                        VStack(alignment: .leading, spacing: 10){
                            Button {
                                withAnimation { showSheet.toggle()}
                            } label: {
                                Text("\(timeFrom) - \(timeTo)")
                                    .style(.body)
                                
                                Image("time")
                                    .resizable()
                                    .frame(width:15,height:15)
                            }
                            .padding(12)
                            .overlay(
                                Capsule()
                                    .stroke(Color.secondaryGray, lineWidth: 0.3)
                            )
                            Text("Early Check-in will be from \(timeFrom) to \(timeTo)")
                                .style(.subheadline1)
                                .multilineTextAlignment(.leading)
                                .padding(.bottom)
                            
                            HStack(alignment: .center) {
                                // Spacer()
                                Button {
                                    if percentageAdded > 1 {
                                        percentageAdded -= 1
                                    }
                                } label: {
                                    Image("minus")
                                }
                                
                                
                                Text(String("\(percentageAdded) % of room price"))
                                    .style(.body)
                                    .padding(15)
                                    .clipShape(Capsule())
                                    .background(
                                        Color.primaryGray,
                                        in: Capsule().stroke(lineWidth: 0.3)
                                    ).frame(minWidth: 230)
                                
                                Button {
                                    percentageAdded += 1
                                } label: {
                                    Image("plus")
                                }
                                //Spacer()
                            }
                            Text("Added fee \(percentageAdded)% of your room rate will charged ")
                                .style(.subheadline1)
                                .multilineTextAlignment(.leading)
                                .padding(.bottom)
                        }}
                }
                .padding(.top)
                .padding(.horizontal,5)
                
                Divider()
                
                VStack(alignment: .leading, spacing: 10) {
                    Toggle(isOn: $allowLateCheckOut) {
                        Text("Allow Late Check-out")
                            .font(.title2)
                            .fontWeight(.semibold)
                    }
                    .padding(.bottom)
                    //.toggleStyle(iOSCheckboxToggleStyle())
                    
                    if allowLateCheckOut {
                        VStack(alignment: .leading, spacing: 10){
                            Button {
                                withAnimation { showSheet.toggle()}
                            } label: {
                                Text("\(timeFrom) - \(timeTo)")
                                    .style(.body)
                                
                                Image("time")
                                    .resizable()
                                    .frame(width:15,height:15)
                            }
                            .padding(12)
                            .overlay(
                                Capsule()
                                    .stroke(Color.secondaryGray, lineWidth: 0.3)
                            )
                            Text("Early Check-in will be from \(timeFrom) to \(timeTo)")
                                .style(.subheadline1)
                                .multilineTextAlignment(.leading)
                                .padding(.bottom)
                            
                            HStack(alignment: .center) {
                                // Spacer()
                                Button {
                                    if percentageAdded > 1 {
                                        percentageAdded -= 1
                                    }
                                } label: {
                                    Image("minus")
                                }
                                
                                
                                Text(String("\(percentageAdded) % of room price"))
                                    .style(.body)
                                    .padding(15)
                                    .clipShape(Capsule())
                                    .background(
                                        Color.primaryGray,
                                        in: Capsule().stroke(lineWidth: 0.3)
                                    ).frame(minWidth: 230)
                                
                                Button {
                                    percentageAdded += 1
                                } label: {
                                    Image("plus")
                                }
                                //Spacer()
                            }
                            Text("Added fee \(percentageAdded)% of your room rate will charged ")
                                .style(.subheadline1)
                                .multilineTextAlignment(.leading)
                                .padding(.bottom)
                        }}
                }
                .padding(.top)
                .padding(.horizontal,5)
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
                        GiveYourPricingView()
                    } label: {
                        Text(String.Hosting.next)
                    }
                    .buttonStyle(secondaryButtonStyle())
                    
                }//: HSTACK
                .padding(.bottom, 20)
                
            
            
        }
        .sheet(isPresented: $showSheet) {
            VStack{
                MultiDatePicker("", selection: $dates, in: Date.now...)
                    .datePickerStyle(GraphicalDatePickerStyle())
                
                HStack {
                    //Back button
                    Button {
                        showSheet.toggle()
                    } label: {
                        Text("Cancel")
                    }
                    .buttonStyle(secondaryButtonStyle(
                        foregroundColor: .black,
                        background: .secondaryLightGray)
                    )
                    .frame(width: 150)
                    
                    Spacer()
                    
                    // Next button
                    Button {
                        showSheet.toggle()
                    } label: {
                        Text("Set")
                    }
                    .frame(width: 150)
                    .buttonStyle(PrimaryButtonStyle(background: .black))
                }
                .padding(.bottom)
            }
            .background(Color.clear)
            .padding([.top, .horizontal], 16)
            .presentationDetents([.medium,.large])
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
        //: NAVIGATION
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .toolbarBackground(Color.background, for: .navigationBar)
    }
}

struct SelectCheckoutOffers_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            SelectCheckoutOffers()
        }
    }
}
