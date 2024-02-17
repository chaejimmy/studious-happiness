////
//  HourlyRoomView.swift
//  bug-free-goggles
//
//  Created by Mac on 9/6/23.
//

import SwiftUI
import LoadingButton
import Drops


struct HourlyBookingView: View {
    @State private var isHourSelected = true
    @State private var isSheetVisible = false
    @State private var isGuestsSheetVisible = false
    @State private var guestsString = "Who is comming?"
    @State private var openTimeSheet = false
    @State private var isLoading = false
    @State private var selectedDuration = 1
    @State private var rentRate = 5
    
    var style = LoadingButtonStyle(
                                  cornerRadius: 27,
                                  backgroundColor: .darkIndigo,
                                  loadingColor: Color.darkIndigo.opacity(0.5),
                                  strokeWidth: 5,
                                  strokeColor: .white)
    
    
    let drop = Drop(
        title: "Success",
        subtitle: "Your proposal sent successfully",
        icon: UIImage(systemName: "checkmark.circle.fill"),
        action: .init {
            print("Drop tapped")
            Drops.hideCurrent()
        },
        position: .top,
        duration: 2.0,
        accessibility: "Alert: Title, Subtitle"
    )
    
    var body: some View {
       
        ScrollView{
            ZStack {
                VStack{

                    HStack{
                        Text("Cerulean Tower\nTokyu Hotel")
                            .font(
                                Font.custom("Inter", size: 32)
                                    .weight(.bold)
                            )
                            .foregroundColor(Color(red: 0.15, green: 0.18, blue: 0.22))
                            .frame(width: 308, alignment: .topLeading)
                        Spacer()
                    }.padding(.bottom)

                    ZStack {

                        VStack{
                            HStack(alignment: .center, spacing: 2) {

                                Text("$")
                                    .font(
                                        Font.custom("Inter", size: 16)
                                            .weight(.semibold)
                                    )
                                    .foregroundColor(.black)
                                
                                CountUpView(value: rentRate)
                                   
                                
                                Text("/")
                                    .font(Font.custom("Inter", size: 14))
                                    .foregroundColor(.black)
                                Text("\(isHourSelected ? "hour" :  "night")")
                                    .font(Font.custom("Inter", size: 12))
                                    .foregroundColor(.black)

                                Spacer()
                            }
                            .padding(.bottom)

                            HStack {
                                HStack(spacing: 0) {
                                    ZStack {
                                        Rectangle()
                                            .foregroundColor(Color.clear)
                                            .frame(width: 61, height: 40)
                                            .cornerRadius(100)

                                        Text("Hour")
                                            .font(
                                                Font.custom("Inter", size: 15)
                                                    .weight(.semibold)
                                            )
                                            .foregroundColor(isHourSelected ? .white : .black)
                                    }
                                    .background(
                                        RoundedRectangle(cornerRadius: 100)
                                            .offset(x: isHourSelected ? 0 : 61, y: 0)
                                            .frame(width: 61, height: 40)
                                            .foregroundColor(Color(red: 0.34, green: 0.31, blue: 0.98))
                                            .animation(.easeInOut(duration: 0.3))
                                    )
                                    .onTapGesture {
                                        withAnimation {
                                            isHourSelected.toggle()
                                        }
                                    }

                                    ZStack {
                                        Rectangle()
                                            .foregroundColor(Color.clear)
                                            .frame(width: 61, height: 40)
                                            .cornerRadius(100)

                                        Text("Day")
                                            .font(
                                                Font.custom("Inter", size: 15)
                                                    .weight(.semibold)
                                            )
                                            .foregroundColor(isHourSelected ? .black : .white)
                                    }
                                    .background(
                                        RoundedRectangle(cornerRadius: 100)
                                            .offset(x: isHourSelected ? -61 : 0, y: 0)
                                            .frame(width: 61, height: 40)
                                            .foregroundColor(Color(red: 0.34, green: 0.31, blue: 0.98))
                                            .animation(.easeInOut(duration: 0.3))
                                    )
                                    .onTapGesture {
                                        withAnimation {
                                            isHourSelected.toggle()
                                        }
                                    }
                                }
                                .frame(height: 44)
                                .background(Color(red: 0.97, green: 0.98, blue: 0.98))
                                .cornerRadius(100)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 100)
                                        .inset(by: 0.5)
                                        .stroke(Color(red: 0.85, green: 0.88, blue: 0.9), lineWidth: 1)
                                )

                                Spacer()
                            }.padding(.bottom)

                            
                            
                            if isHourSelected {
                                HStack{
                                    Text("Select Duration")
                                        .font(
                                            Font.custom("Inter", size: 14)
                                                .weight(.medium)
                                        )
                                        .foregroundColor(Color(red: 0.15, green: 0.18, blue: 0.22))
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                }.padding(.bottom, 5)

                                //                       DropdownView()

                                Button(action: {
                                    withAnimation {
                                        isSheetVisible.toggle()
                                    }
                                }){
                                    HStack{
                                        Text("\(selectedDuration) \(isHourSelected ? "hour" : "day")\(selectedDuration > 1 ? "s" : "")")
                                            .font(
                                                Font.custom("Inter", size: 12)
                                                    .weight(.medium)
                                            )
                                            .foregroundColor(Color(red: 0.15, green: 0.18, blue: 0.22))
                                        Spacer()
                                        Image("arrowBackIcon")
                                            .resizable()
                                            .frame(width: 15, height: 15)
                                            .rotationEffect( Angle(degrees: -90))
                                    }
                                    .padding(.horizontal, 20)
                                    .padding(.vertical, 12)
                                    .frame( height: 48)
                                    .background(.white)
                                    .cornerRadius(100)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 100)
                                            .inset(by: 0.5)
                                            .stroke(Color(red: 0.85, green: 0.88, blue: 0.9), lineWidth: 1)
                                    )
                                }


                                HStack {
                                    Spacer()
                                    Button(action: {
                                        openTimeSheet = true
                                    }){
                                        Text("See available time slots")
                                            .font(
                                                Font.custom("Inter", size: 14)
                                                    .weight(.medium)
                                            )
                                            .foregroundColor(Color(red: 0.34, green: 0.31, blue: 0.98))

                                    }
                                }.padding(.bottom)
                            }else{
                                RangeDatePicker()
                            }
                            

                            HStack{
                                Text("Guests")
                                    .font(
                                        Font.custom("Inter", size: 14)
                                            .weight(.medium)
                                    )
                                    .foregroundColor(Color(red: 0.15, green: 0.18, blue: 0.22))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }.padding(.bottom, 5)


                            Button(action: {
                                withAnimation {
                                    isGuestsSheetVisible.toggle()
                                }
                            }){
                                HStack{
                                    Text(guestsString)
                                        .font(
                                            Font.custom("Inter", size: 12)
                                                .weight(.medium)
                                        )
                                        .foregroundColor(
                                            guestsString == "Who is comming?" ? Color.gray :
                                                Color(red: 0.15, green: 0.18, blue: 0.22))
                                    Spacer()
                                    Image("arrowBackIcon")
                                        .resizable()
                                        .frame(width: 15, height: 15)
                                        .rotationEffect( Angle(degrees: -90))
                                }
                                .padding(.horizontal, 20)
                                .padding(.vertical, 12)
                                .frame( height: 48)
                                .background(.white)
                                .cornerRadius(100)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 100)
                                        .inset(by: 0.5)
                                        .stroke(Color(red: 0.85, green: 0.88, blue: 0.9), lineWidth: 1)
                                )
                            }.padding(.bottom)

                            // text-sm/Regular



                            VStack {

                                Text("You won’t be charged yet")
                                    .font(Font.custom("Inter", size: 14))
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(Color(red: 0.42, green: 0.45, blue: 0.5))
                                    .frame(width: 292, alignment: .center)
                                    .padding(.bottom)

                                HStack{
                                    Text("$\(isHourSelected ? 5 : 75) x \(selectedDuration) \(isHourSelected ? "hours" : "nights")")
                                        .font(Font.custom("Inter", size: 14))
                                        .foregroundColor(.black)
                                        .frame(width: 235, alignment: .leading)
                                    Spacer()
                                    
                                    Text("$")
                                        .font(
                                            Font.custom("Inter", size: 16)
                                                .weight(.semibold)
                                        )
                                        .foregroundColor(.black)
                                    CountUpView(value: rentRate * selectedDuration)
//                                    Text("$525")
//                                        .font(Font.custom("Inter", size: 14))
//                                        .multilineTextAlignment(.trailing)
//                                        .foregroundColor(.black)
//                                        .frame(width: 35, alignment: .trailing)
                                }.padding(.bottom, 7)

                                if selectedDuration > 6 && !isHourSelected {
                                    HStack{
                                        Text("Weekly discount")
                                            .font(Font.custom("Inter", size: 14))
                                            .foregroundColor(.black)
                                            .frame(width: 237, alignment: .leading)
                                        Spacer()
                                        Text("-$28")
                                            .font(Font.custom("Inter", size: 14))
                                            .multilineTextAlignment(.trailing)
                                            .foregroundColor(Color(red: 0.06, green: 0.73, blue: 0.51))
                                            .frame(width: 33, alignment: .trailing)
                                    }.padding(.bottom)
                                }
                               

                                Rectangle()
                                  .foregroundColor(.clear)
                                  .frame( height: 0.7)
                                  .background(Color(red: 0.9, green: 0.91, blue: 0.92))
                                  .padding(.bottom)

                                HStack{
                                    Text("Total")
                                      .font(
                                        Font.custom("Inter", size: 14)
                                          .weight(.medium)
                                      )
                                      .foregroundColor(.black)
                                      .frame(maxWidth: .infinity, alignment: .leading)
                                    Spacer()
                                    Text("$")
                                        .font(
                                            Font.custom("Inter", size: 16)
                                                .weight(.semibold)
                                        )
                                        .foregroundColor(.black)
                                    CountUpView(value: rentRate * selectedDuration )
//                                    Text("$493")
//                                      .font(
//                                        Font.custom("Inter", size: 14)
//                                          .weight(.medium)
//                                      )
//                                      .multilineTextAlignment(.trailing)
//                                      .foregroundColor(.black)
                                }
                            }
                            
//                            LoadingButton(action: {
//                                isLoading = true
//                                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
//                                    isLoading = false
//                                    Drops.show(drop)
//                                }
//                            }, isLoading: $isLoading, style: style) {
//                                       Text("Send Proposal").foregroundColor(Color.white)
//                                   }  .padding(.vertical, 16)

                            NavigationLink{
                                HourlyConfirmationView()
                        } label: {
                            Text("Continue")
                        }
                        .buttonStyle(PrimaryButtonStyle(background: .darkIndigo))







                        }.padding(.vertical, 25).padding(.horizontal)

                    }

                    .background(.white)
                    .cornerRadius(24)
                    .shadow(color: Color(red: 0.06, green: 0.09, blue: 0.16).opacity(0.1), radius: 12.5, x: 0, y: 20)
                    .shadow(color: Color(red: 0.06, green: 0.09, blue: 0.16).opacity(0.1), radius: 5, x: 0, y: 8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 24)
                            .inset(by: 0.5)
                            .stroke(Color(red: 0.85, green: 0.88, blue: 0.9), lineWidth: 1)
                    )
                }.padding()


                    .sheet(isPresented: $isSheetVisible) {
                        SheetView { duration in
                            selectedDuration = duration
                        }
                            .presentationDetents([.height(280)])
                    } .sheet(isPresented: $isGuestsSheetVisible) {
                        GuestsSheetView(action: {adult,child, infant, pet in
                            guestsString = "";
                            if(adult != 0){
                                guestsString =  "\(guestsString)\(adult) adults,"
                            }
                            if(child != 0){
                                guestsString = "\(guestsString) \(child) childs,"
                            }
                            if(infant != 0){
                                guestsString = "\(guestsString) \(infant) infants,"
                            }
                            if(pet != 0){
                                guestsString = "\(guestsString) \(pet) pets,"
                            }

                            if(guestsString.hasPrefix(" ")){
                                guestsString = String(guestsString.dropFirst())
                            }

                            if(guestsString.hasSuffix(",")){
                                guestsString = String(guestsString.dropLast())
                            }

                            if( guestsString.isEmpty){
                                guestsString = "Who is comming?"
                            }

                        })
                        .presentationDetents([.height(370)])
                    }

            }
        } .sheet(isPresented: $openTimeSheet) {
            TimeSelectionView(){
                openTimeSheet = false
            }
        }.onChange(of: isHourSelected) { newValue in
            rentRate = newValue ? 75 : 5
        }
        
//        .navigationDestination(isPresented: $isTimeShowing) {
//
//        }
        
       
      
    }
}

struct HourlyBookingView_Previews: PreviewProvider {
    static var previews: some View {
        HourlyBookingView()
    }
}


struct SheetView: View {
    @Environment(\.dismiss) var dismiss
    @State private var selectedTime = 5
    let timeRange = 1...10
    
    let callback: (Int) -> Void
    
    var body: some View {
        VStack {
            Text("Select Duration")
                .font(.title)
                .padding(.top,40)
            
            HStack {
                Picker("Timer", selection: $selectedTime) {
                    ForEach(timeRange, id: \.self) { time in
                        Text("\(time)")
                            .font(.system(size: 30, weight: .bold, design: .default)) // Adjust font size
                            .tag(time)
                            .frame(maxWidth: .infinity) // Expand the frame to increase spacing
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .frame(width: 150, height: 150)
                
            }
            
            
            HStack {
                Button(action:{
                    dismiss()
                    callback(selectedTime)
                }) {
                    HStack(alignment: .center, spacing: 6) {
                        Spacer()
                        Text("Confirm")
                            .font(
                                Font.custom("Inter", size: 15)
                                    .weight(.semibold)
                            )
                            .foregroundColor(.white)
                        Spacer()
                    }
                    .padding(.vertical, 16)
                    
                    .frame(alignment: .center)
                    .background(Color(red: 0.34, green: 0.31, blue: 0.98))
                    .cornerRadius(100)
                    .shadow(color: Color(red: 0.06, green: 0.09, blue: 0.16).opacity(0.04), radius: 1, x: 0, y: 1)
                }
            }.padding(.horizontal)
        }
    }
}


struct GuestsSheetView: View {
    let action: (Int, Int, Int, Int) -> Void
    @State private var guests: Array<Int> = [0,0,0,0]
    
    
    @Environment(\.dismiss) var dismiss
    @State private var selectedTime = 5
    
    
    let timeRange = 1...10
    
    var body: some View {
        VStack {
            HStack {
                Text("Who's coming?")
                    .fontWeight(.bold)
                    .font(Font.system(size: 19))
                Spacer()
            }.padding(.top, 20).padding(.leading)
            
            VStack{
                
                CounterView(lable: "Adult", subLable: "Ages 13 or above"){ count in
                    guests[0] = count
                }
                CounterView(lable: "Children", subLable: "Ages 2-12"){count in
                    guests[1] = count
                }
                CounterView(lable: "Infants", subLable: "Ages 0-2"){count in
                    guests[2] = count
                }
                CounterView(lable: "Pet", subLable: ""){count in
                    guests[3] = count
                    
                }
            }.padding()
            
            HStack {
                Button(action:{
                    dismiss()
                    action(guests[0],guests[1],guests[2],guests[3])
                }) {
                    HStack(alignment: .center, spacing: 6) {
                        Spacer()
                        Text("Confirm")
                            .font(
                                Font.custom("Inter", size: 15)
                                    .weight(.semibold)
                            )
                            .foregroundColor(.white)
                        Spacer()
                    }
                    .padding(.vertical, 16)
                    
                    .frame(alignment: .center)
                    .background(Color(red: 0.34, green: 0.31, blue: 0.98))
                    .cornerRadius(100)
                    .shadow(color: Color(red: 0.06, green: 0.09, blue: 0.16).opacity(0.04), radius: 1, x: 0, y: 1)
                }
            }.padding(.horizontal)
        }
    }
}

