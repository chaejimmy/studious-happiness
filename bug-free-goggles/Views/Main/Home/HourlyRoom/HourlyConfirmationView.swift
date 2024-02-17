////
//  HourlyRoomView.swift
//  bug-free-goggles
//
//  Created by Mac on 9/6/23.
//

import SwiftUI
import LoadingButton
import Drops


struct HourlyConfirmationView: View {
    @State private var isHourSelected = true
    @State private var isSheetVisible = false
    @State private var isGuestsSheetVisible = false
    @State private var guestsString = "Who is comming?"
    @State private var openTimeSheet = false
    @State private var isLoading = false
    @State private var selectedDuration = 1
    @State private var rentRate = 5
    @State private var selectedOption: Int = 0
    
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

                                Text("$75")
                                    .font(
                                        Font.custom("Inter", size: 16)
                                            .weight(.semibold)
                                    )
                                    .foregroundColor(.black)
                                
                                   
                                
                                Text("/")
                                    .font(Font.custom("Inter", size: 14))
                                    .foregroundColor(.black)
                                Text("night")
                                    .font(Font.custom("Inter", size: 12))
                                    .foregroundColor(.black)

                                Spacer()
                            }
                            .padding(.bottom)
                            
                            
                   
                            VStack {
                                HStack(spacing: 0) {
                                        VStack(alignment: .leading) {
                                            Text("Check In")
                                                .font(Font.custom("Poppins", size: 14).weight(.light))
                                                .foregroundColor(Color(red: 0.61, green: 0.64, blue: 0.69))
                                                .padding(.leading)
                                                .padding(.top).padding(.bottom, 1)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            Text("06 Feb 2023")
                                              .font(
                                                Font.custom("Poppins", size: 18)
                                                  .weight(.semibold)
                                              )
                                              .padding(.leading)
                                              .padding(.bottom)
                                              
                                              .foregroundColor(Color(red: 0.07, green: 0.09, blue: 0.15))
                                        }
                                        
                                        Divider() // Vertical line
                                        
                                        VStack(alignment: .leading) {
                                            Text("Check Out")
                                                .font(Font.custom("Poppins", size: 14).weight(.light))
                                                .foregroundColor(Color(red: 0.61, green: 0.64, blue: 0.69))
                                                .padding(.leading)
                                                .padding(.top).padding(.bottom, 1)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            Text("16 Feb 2023")
                                              .font(
                                                Font.custom("Poppins", size: 18)
                                                  .weight(.semibold)
                                              )
                                              .padding(.leading)
                                              .padding(.bottom)
                                              
                                              .foregroundColor(Color(red: 0.07, green: 0.09, blue: 0.15))
                                        }
                                    }
                                 
                                
                                Divider().padding(.top, -7)
                                
                                VStack(alignment: .leading) {
                                    Text("Roommate")
                                        .font(Font.custom("Poppins", size: 14).weight(.light))
                                        .foregroundColor(Color(red: 0.61, green: 0.64, blue: 0.69))
                                        .padding(.leading)
                                        .padding(.bottom, 1)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    Text("2 Roommates")
                                      .font(
                                        Font.custom("Poppins", size: 18)
                                          .weight(.semibold)
                                      )
                                      .padding(.leading)
                                      .padding(.bottom)
                                      
                                      .foregroundColor(Color(red: 0.07, green: 0.09, blue: 0.15))
                                }
                            }
                            .frame(maxWidth: .infinity)
                            .background(
                                RoundedRectangle(cornerRadius: 14)
                                    .stroke(Color(red: 0.9, green: 0.91, blue: 0.92), lineWidth: 1)
                            ).padding(.bottom, 20)
                     
                          
                            
                            VStack(alignment: .leading) {
                                Text("Room Type selection")
                                  .font(
                                    Font.custom("Poppins", size: 16)
                                      .weight(.semibold)
                                  ).padding(.leading, 5)
                                  .foregroundColor(Color(red: 0.07, green: 0.09, blue: 0.15))
//                                VStack {
//                                             HStack(spacing: 0) {
//
//                                                         Text("06 Feb 2023")
//                                                           .font(
//                                                             Font.custom("Poppins", size: 18)
//                                                               .weight(.semibold)
//                                                           )
//                                                           .padding()
//
//                                                           .foregroundColor(Color(red: 0.07, green: 0.09, blue: 0.15))
//                                                 Spacer()
//
//
//
//                                                 }
//
//
//                                             Divider().padding(.top, -7)
//
//                                             VStack(alignment: .leading) {
//                                                 Text("Roommate")
//                                                     .font(Font.custom("Poppins", size: 14).weight(.light))
//                                                     .foregroundColor(Color(red: 0.61, green: 0.64, blue: 0.69))
//                                                     .padding(.leading)
//                                                     .padding(.bottom, 1)
//                                                 .frame(maxWidth: .infinity, alignment: .leading)
//                                                 Text("2 Roommates")
//                                                   .font(
//                                                     Font.custom("Poppins", size: 18)
//                                                       .weight(.semibold)
//                                                   )
//                                                   .padding(.leading)
//                                                   .padding(.bottom)
//
//                                                   .foregroundColor(Color(red: 0.07, green: 0.09, blue: 0.15))
//                                             }
//                                         }
//                                         .frame(maxWidth: .infinity)
//                                         .background(
//                                             RoundedRectangle(cornerRadius: 14)
//                                                 .stroke(Color(red: 0.9, green: 0.91, blue: 0.92), lineWidth: 1)
//                                     )
                                
                                SelectableToggleView(selectedOption: $selectedOption)
                                    .frame(maxWidth: .infinity)
                                    .background(
                                        RoundedRectangle(cornerRadius: 14)
                                            .stroke(Color(red: 0.9, green: 0.91, blue: 0.92), lineWidth: 1))
                            }
                          
                            VStack {

                              
                                HStack{
                                    Text("5 nights")
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
                                    CountUpView(value: selectedOption == 1 ? 375 : 830)
//                                    Text("$525")
//                                        .font(Font.custom("Inter", size: 14))
//                                        .multilineTextAlignment(.trailing)
//                                        .foregroundColor(.black)
//                                        .frame(width: 35, alignment: .trailing)
                                }.padding(.bottom, 7)

                                HStack{
                                    Text("Totel service fee")
                                        .font(Font.custom("Inter", size: 14))
                                        .foregroundColor(.black)
                                        .frame(width: 235, alignment: .leading)
                                    Spacer()
                                    
                                  
                                    Text("$125")
                                        .font(Font.custom("Inter", size: 14))
                                        .multilineTextAlignment(.trailing)
                                        .foregroundColor(.black)
                                        .frame(width: 35, alignment: .trailing)
                                }.padding(.bottom, 7)


                                Rectangle()
                                  .foregroundColor(.clear)
                                  .frame( height: 0.7)
                                  .background(Color(red: 0.9, green: 0.91, blue: 0.92))
                                  .padding(.bottom)

                                HStack{
                                    Text("Total before taxes")
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
                                    CountUpView(value: (selectedOption == 1 ? 375 : 830) + 125 )
//                                    Text("$493")
//                                      .font(
//                                        Font.custom("Inter", size: 14)
//                                          .weight(.medium)
//                                      )
//                                      .multilineTextAlignment(.trailing)
//                                      .foregroundColor(.black)
                                }
                            }.padding(.top, 30)
                            
                            
//                            PaymentView()
                            
                            NavigationLink{
                                PaymentView()
                        } label: {
                            Text("Continue")
                        }
                        .buttonStyle(PrimaryButtonStyle(background: .darkIndigo))
                            
//                            LoadingButton(action: {
//                                isLoading = true
//                                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
//                                    isLoading = false
//                                    Drops.show(drop)
//                                }
//                            }, isLoading: $isLoading, style: style) {
//                                       Text("Send Proposal").foregroundColor(Color.white)
//                                   }  .padding(.vertical, 16)







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

struct HourlyConfirmationView_Previews: PreviewProvider {
    static var previews: some View {
        HourlyConfirmationView()
    }
}



struct SelectionModel: Identifiable {
    let id = UUID()
    var title: String
    var value: String
    var isSelected: Bool
    var description: String?
}

struct SelectableView: View {
    var selectionModel: SelectionModel
    var isSelected: Bool
    var toggleSelection: () -> Void
    
    var body: some View {
        Button(action: {
            toggleSelection()
        }) {
            VStack(alignment: .leading) {
                HStack {
                    Text(selectionModel.title)
                        .font(Font.custom("Poppins", size: 14).weight(.light))
                        .foregroundColor(.gray)
                        .padding([.leading, .top, .bottom])
                        .frame(alignment: .leading)
                    Text(selectionModel.value)
                      .font(Font.custom("Roboto", size: 14))
                      .foregroundColor(Color(red: 0.13, green: 0.13, blue: 0.13))
                    
                    Spacer()
                    
                    ZStack{
                        if  isSelected {
                            ZStack {}
                            .frame(width: 22, height: 22)
                            .background(.white)
                            .cornerRadius(11)
                            .overlay(
                              RoundedRectangle(cornerRadius: 11)
                                .inset(by: 3.5)
                                .stroke(Color(red: 0.13, green: 0.13, blue: 0.13), lineWidth: 7)
                            )
                        }else{
                            ZStack { }
                            .frame(width: 22, height: 22)
                            .background(.white)
                            .cornerRadius(11)
                            .overlay(
                              RoundedRectangle(cornerRadius: 11)
                                .inset(by: 0.5)
                                .stroke(Color(red: 0.69, green: 0.69, blue: 0.69), lineWidth: 1)
                            )
                        }
                    }.padding(.trailing)
                    
                   
                }
                
                if selectionModel.description != nil {
                    Text(selectionModel.description!)
                      .font(Font.custom("Roboto", size: 12))
                      .multilineTextAlignment(.leading)
                      .padding(.leading)
                      .padding(.trailing)
                      .padding(.bottom)
                      .padding(.top, -10)
                      .foregroundColor(Color(red: 0.44, green: 0.44, blue: 0.44))
                }
              
            }
        }
    }
}

struct SelectableToggleView: View {
    @Binding var selectedOption: Int
    @State private var options: [SelectionModel] = [
        SelectionModel(title: "With Roommates:", value: "$375", isSelected: false),
        SelectionModel(title: "Without Roommates:", value: "$830",isSelected: false, description: "This Room will be occupied by you only\nand you are going to pay full fare for this room")
    ]

    var body: some View {
        VStack {
            ForEach(0..<options.count) { index in
                VStack {
                    SelectableView(selectionModel: options[index], isSelected: selectedOption == index) {
                        selectedOption = index
                        for i in 0..<options.count {
                            options[i].isSelected = i == index
                        }
                    }
                    
                    if index != options.count - 1 {
                        Divider()
                    }
                }
//                .background(
//                    RoundedRectangle(cornerRadius: 24)
//                        .stroke(Color(red: 0.9, green: 0.91, blue: 0.92), lineWidth: 1)
//                )
            }
            
        }
        .padding(1)
    }
}
