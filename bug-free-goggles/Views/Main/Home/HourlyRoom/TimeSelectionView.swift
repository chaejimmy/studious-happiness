////
//  TimeSelectionView.swift
//  bug-free-goggles
//
//  Created by Mac on 9/10/23.
//

import SwiftUI
import LoaderUI

struct TimeSelectionView: View {
    let dismiss: () -> Void
    @State var currentDate = Date()
    @State var selectedTime: Date?
    @State var isSheetVisible = false
    @State var isLoading = true
    @State var selctedDatePicker = Date()
    
    func changeDate(){
        isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            isLoading = false
        }
    }
    
    
    private var formattedDateHeader: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM yyyy"
        return formatter.string(from: currentDate)
    }
    
    private var isToday: Bool {
        let components1 = Calendar.current.dateComponents([.day, .month, .year], from: Date())
        let components2 = Calendar.current.dateComponents([.day, .month, .year], from: currentDate)

        return components1.day == components2.day &&
            components1.month == components2.month &&
            components1.year == components2.year
    }
    
    var body: some View {
        VStack{
            
            HStack {
                Button{
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .resizable()
                        .frame(width: 13, height: 13)
                        .padding(10)
                        .foregroundColor(.darkGray)
                }
                Spacer()
            }
            .padding(.horizontal)
            .padding(.top)
            
            HStack{
                HStack{
                    if !isToday {
                        Button(action: {
                            var nextDay  =  Calendar.current.date(byAdding: .day, value: -1, to: currentDate)!
                             currentDate = nextDay
                            changeDate()
                        }) {
                            Image(systemName: "chevron.left")
                                .foregroundColor(Color.darkGray)
                                .font(.title)
                                .padding(.top, 50)
                        }
                    }
                  
                }.frame(maxWidth: .infinity)
                VStack{
                    Text(formattedDateHeader)
                        .font(
                            Font.custom("Inter", size: 16)
                                .weight(.semibold)
                        )
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color(red: 0.25, green: 0.25, blue: 0.25))
                        .frame(width: 86, alignment: .top).padding(.bottom, 10)
                    Text("\(currentDate.weekDayName)")
                        .font(
                            Font.custom("Inter", size: 16)
                                .weight(.semibold)
                        )
                        .foregroundColor(.black)
                    Text("\(currentDate.day)")
                        .font(
                            Font.custom("Inter", size: 48)
                                .weight(.semibold)
                        )
                        .foregroundColor(.black)
                        .frame(alignment: .center)
                }.frame(maxWidth: .infinity).onTapGesture {
                    selctedDatePicker = currentDate
                    isSheetVisible = true
                }
                HStack{
                    Button(action: {
                       var nextDay  =  Calendar.current.date(byAdding: .day, value: 1, to: currentDate)!
                        currentDate = nextDay
                        changeDate()
                    }) {
                        Image(systemName: "chevron.right")
                            .foregroundColor(Color.darkGray)
                            .font(.title)
                            .padding(.top, 50)
                    }
                }
                
                .frame(maxWidth: .infinity)
                
            }
            Rectangle().frame(width: .infinity, height: 1).foregroundColor(Color.midGray).padding(.horizontal)
            if isLoading {
                Spacer()
                BallClipRotate()
                    .foregroundColor(Color.darkIndigo).frame(width: 70, height: 70)
                Spacer()
            }else{
                AnimatedGrid(selectedTime: $selectedTime, duration: 1)
            }
            
            Button(action:{
                print("clicked")
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
            }.padding(.horizontal)
            
        } .sheet(isPresented: $isSheetVisible) {
            VStack{
                HStack {
                    Text("Select Date")
                        .fontWeight(.bold)
                        .font(Font.system(size: 19))
                    Spacer()
                    Button{
                        isSheetVisible = false
                    } label: {
                        Image(systemName: "xmark")
                            .resizable()
                            .frame(width: 13, height: 13)
                            .padding(10)
                            .foregroundColor(.darkGray)
                    }.padding()
                  
                }.padding(.top, 10).padding(.leading)
                
                DatePicker("Select a Date", selection: $selctedDatePicker, in: Date()..., displayedComponents: [.date])
                               .datePickerStyle(WheelDatePickerStyle())
                               .labelsHidden()
                               .frame(height: 100)
                               .padding()
                Spacer()
                HStack {
                    Button(action:{
                        isSheetVisible = false
                        currentDate = selctedDatePicker
                        changeDate()
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
                .presentationDetents([.height(320)])
        }.onAppear {
            changeDate()
        }
        
    }
}

struct TimeSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        TimeSelectionView(){
            
        }
    }
}
