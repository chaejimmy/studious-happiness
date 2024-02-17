////
//  GiveYourAvailability.swift
//  bug-free-goggles
//
//  Created by Mac on 17/05/23.
//

import SwiftUI

struct GiveYourAvailability: View {
    // MARK: - PROPERTIES
    @Environment(\.calendar) var calendar
    @Environment(\.presentationMode) var presentationMode
    
    @State private var isDaySelected = true
    @State var dates: Set<DateComponents> = []
    @State private var showSheet = false
    
    
    var summary: String {
        dates.compactMap { components in
            calendar.date(from: components)?.formatted(date: .numeric, time: .omitted)
        }.formatted()
    }
    
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
    
    @State var showAvailability = false
    // MARK: - BODY
    var body: some View {
        // MARK: - TOP HEADER
        ZStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 15){
                // MARK: - HEADER
                HeaderView(
                    title: String.Hosting.giveYourAvailabilityPageTitle,
                    subTitle: String.Hosting.giveYourAvailabilityPageSubTitle
                )
                
                // MARK: - BODY - DAY/HOUR
                HStack {
                    Button {
                        withAnimation {
                            isDaySelected = true
                        }
                        
                    } label: {
                        Text(String.Hosting.day)
                            .padding(.horizontal , 25)
                            .padding(.vertical , 12)
                            .background(isDaySelected ? Color.appPrimary : Color.clear)
                            .clipShape(Capsule())
                            .foregroundColor(isDaySelected ? .white : Color.secondaryGray)
                            .font(.system(size: 17, weight: .semibold))
                    }
                    
                    Button {
                        withAnimation {
                            isDaySelected = false
                        }
                    } label: {
                        Text(String.Hosting.hour)
                            .padding(.horizontal , 25)
                            .padding(.vertical , 12)
                            .background(isDaySelected ? Color.clear :  Color.appPrimary )
                            .clipShape(Capsule())
                            .foregroundColor(isDaySelected ? Color.secondary : .white)
                            .font(.system(size: 17, weight: .semibold))
                    }
                }
                
                // MARK: - CHECK IN DATE
                Text("Check-In")
                    .style(.subheadline1)
                
                Button {
                    withAnimation {
                        showSheet.toggle()
                    }
                } label: {
                    Text(isDaySelected ? today : "\(timeFrom) - \(timeTo)")
                        //.foregroundColor(.primary)
                        .style(.small)
                    
                    isDaySelected ?  Image("calendar") : Image("time")
                }
                .padding(12)
                .overlay(
                    Capsule()
                        .stroke(Color.secondaryGray, lineWidth: 0.3)
                )
                
                // MARK: - CHECK OUT TIME
                Text("Check-Out").style(.subheadline1)
                
                Button {
                    withAnimation{
                        showSheet.toggle()}
                } label: {
                    Text(isDaySelected ? today : "\(timeFrom) - \(timeTo)")
                        //.foregroundColor(.primary)
                        .style(.small)
                    
                    isDaySelected ?  Image("calendar") : Image("time")
                }
                .padding(12)
                .overlay(
                    Capsule()
                        .stroke(Color.secondaryGray, lineWidth: 0.3)
                )
                
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
                        SelectCheckoutOffers()
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
            
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .toolbarBackground(Color.background, for: .navigationBar)
    }
}

struct GiveYourAvailability_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            GiveYourAvailability()
        }
    }
}
