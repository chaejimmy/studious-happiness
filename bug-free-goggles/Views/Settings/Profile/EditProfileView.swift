//
//  ProfileView.swift
//  Totel (iOS)
//
//  Created by Hatesh Kumar on 10/05/2023.
//

import SwiftUI

struct EditProfileView : View {
    
    @Environment(\.presentationMode) var presentationMode
    
    
    static let shared = BasicSetUpViewModel()
    
    @ObservedObject var basicSetUpVM = BasicSetUpViewModel()
    
    
    var body: some View {
        
        ScrollView {
            VStack(alignment: .leading) {
                
                
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 10, height: 10)
                        .foregroundColor(.black)
                        .padding()
                        .background(Color("DarkWhite"))
                        .clipShape(Circle())
                }
                
                
                Text("Profile")
                    .font(.system(size: 28, weight: .bold))
                    .padding(.top,15)
                    .padding(.leading,5)
                
                
            Group {
                    
                    NameView()
                    DateAndGenderView()
                    
                    
                    Text("Bio")
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundColor(.black)
                        .padding(.top)
                    
                    TextField("Hi there! I’m creative individual who loves to spend time outdoors and explore new places. I work as a graphic designer and enjoy spending my free time drawing and painting.", text: $basicSetUpVM.firstName)
                        .font(.system(size: 17, weight: .regular))
                        .foregroundColor(.black)
                        .frame(minHeight: 60)
                        .padding()
                        .multilineTextAlignment(.leading)
                    
                        .background {
                            RoundedRectangle(cornerRadius: 0)
                                .fill(Color.lightGray)
                        }
                    
                    
                    
                    
                    Text("Email Address")
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundColor(.black)
                        .padding(.top)
                    
                    CustomTextField(placeholder: "Hateshkumar701@gmail.com", value: $basicSetUpVM.email)//,cornerRadius: 0
                    
                    
                    
                    Text("Phone Number")
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundColor(.black)
                        .padding(.top)
                    
                    HStack(spacing: 12) {
                        Button {
                        } label: {
                            HStack {
                                Image("Flag")
                                    .resizable()
                                    .frame(width: 28, height: 28)
                                    .clipShape(Circle())
                                Text("(\("+1"))")
                                    .font(.system(size: 13, weight: .semibold))
                                    .foregroundColor(.black)
                            }
                            .padding(8)
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(Color.lightGray)
                            )
                        }
                        
                        TextField("Enter your mobile phone", text: $basicSetUpVM.mobileNo)
                            .keyboardType(.numberPad)
                            .padding(.horizontal)
                            .padding(.vertical, 14)
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(Color.lightGray)
                            )
                    }
                }
                
                Button {
                    basicSetUpVM.selectedTab = 2
                } label: {
                    Text("Save")
                }
                .buttonStyle(PrimaryButtonStyle(isDisable: basicSetUpVM.dateContinueDisable))
                .disabled(basicSetUpVM.dateContinueDisable)
                .padding(.top)
                
                
            }
            .padding(.leading) // Add left
            .padding(.trailing,10)
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
        }
        .sheet(isPresented: $basicSetUpVM.showDatePickerSheet) {
            DatePickerSheet(){ selectedDate in
                basicSetUpVM.date = selectedDate
            }
        }
    }
    
    func NameView() -> some View {
        HStack(spacing: 12) {
            CustomTextField(placeholder: "First name", value: $basicSetUpVM.firstName)
            CustomTextField(placeholder: "Last name", value: $basicSetUpVM.lastName)
        }        .padding(.trailing,10)
        
    }
    
    
    
    func DateAndGenderView() -> some View {
        VStack(alignment: .leading){
            
            Text("Date of Birth?")
                .font(.system(size: 15, weight: .semibold))
                .foregroundColor(.black)
                .padding(.top)
            Button {
                basicSetUpVM.showDatePickerSheet = true
            } label: {
                HStack(spacing: 12) {
                    DateItem(title: basicSetUpVM.day)
                    DateItem(title: basicSetUpVM.month)
                    DateItem(title: basicSetUpVM.year)
                }
            }
            
//            HStack(spacing: 12) {
//               CustomTextField(placeholder: "Day", value: $basicSetUpVM.day, keyboardType: .numberPad)
//               CustomTextField(placeholder: "Month", value: $basicSetUpVM.month, keyboardType: .numberPad)
//               CustomTextField(placeholder: "Year", value: $basicSetUpVM.year, keyboardType: .numberPad)
//            }
            
            
            Text("Gender")
                .font(.system(size: 15, weight: .semibold))
                .foregroundColor(.black)
                .padding(.top, 8)
            HStack(spacing: 12) {
                ForEach(GenderType.allCases, id: \.title) { gender in
                    ChipView(
                        title: gender.title,
                        isSelected: basicSetUpVM.selectedGender == gender
                    ) {
                        withAnimation(.easeInOut) {
                            basicSetUpVM.selectedGender = gender
                        }
                    }
                }
            }
            
            
        }
        .padding(.trailing,10)
        
    }
    
}



