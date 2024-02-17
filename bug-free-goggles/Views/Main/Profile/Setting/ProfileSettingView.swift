////
//  ProfileSettingView.swift
//  bug-free-goggles
//
//  Created by Mac on 09/05/23.
//

import SwiftUI
import CountryPicker

struct ProfileSettingView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var birthDate: String = Date().string(.ddMMyyyySlashed)
    @State private var selectedGender: GenderType = .male
    @State private var bio: String = ""
    @State private var emailAddress: String = ""
    @State var country: Country = CountryManager.shared.currentCountry ?? Country.init(countryCode: "US")
    @State var mobileNo: String = ""
    @State var showCountryPicker: Bool = false
    
    var body: some View {
        ZStack(alignment: .bottom) {
            NavScrollView(title: "Profile", leftAction: { dismiss() }) {
                VStack(spacing: 24) {
                    HStack(spacing: 12) {
                        TextField("First Name", text: $firstName)
                            .rectangleBgStyle()
                        TextField("Last Name", text: $lastName)
                            .rectangleBgStyle()
                    }
                    .font(.system(size: 17, weight: .regular))
                    .padding(.horizontal)
                    
                    LabelContentView(title: "Date of Birth?", spacing: 12) {
                        DateInputTextField(placeholder: "Placeholder", text: $birthDate, icon: "calendarIcon")
                        .rectangleBgStyle()
                        .padding(.horizontal)
                    }
                    
                    LabelContentView(title: "Pronouns", spacing: 12) {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(GenderType.allCases, id: \.title) { genderType in
                                    ChipView(
                                        title: genderType.pronouns,
                                        bgColor: .appPrimary,
                                        paddingHorizonatal: 32,
                                        isSelected: selectedGender == genderType
                                    ) {
                                        selectedGender = genderType
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                    
                    LabelContentView(title: "Bio", spacing: 12) {
                        TextEditor(text: $bio)
                            .frame(height: 138)
                            .scrollContentBackground(.hidden)
                            .rectangleBgStyle()
                            .padding(.horizontal)
                        
                        
                    }
                    
                    LabelContentView(title: "Email Address", spacing: 12) {
                        HStack(spacing: 12) {
                            Image("mailIcon")
                            TextField("Email Address", text: $emailAddress)
                        }
                        .rectangleBgStyle()
                        .padding(.horizontal)
                    }
                    
                    LabelContentView(title: "Phone Number", spacing: 12) {
                        HStack {
                            Button {
                                showCountryPicker = true
                            } label: {
                                HStack(spacing: 12) {
                                    Image(uiImage: country.flag ?? UIImage())
                                        .resizable()
                                        .frame(width: 28, height: 28)
                                        .clipShape(Circle())
                                    Text("\(country.dialingCode ?? "+1")")
                                        .foregroundColor(.black)
                                }
                            }
                            TextField("Phone Number", text: $mobileNo)
                        }
                        .font(.system(size: 17, weight: .regular))
                        .rectangleBgStyle()
                        .padding(.horizontal)
                        .sheet(isPresented: $showCountryPicker) {
                            CountryPickerViewProxy { choosenCountry in
                                country = choosenCountry
                            }
                        }
                    }
                    Spacer(minLength: 100)
                }
            }
            Button {
                
            } label: {
                Text("Save")
            }
            .buttonStyle(PrimaryButtonStyle())
            .padding()
            .background(Color.white)

        }
        .toolbar(.hidden, for: .navigationBar)
    }
}

struct ProfileSettingView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileSettingView()
    }
}
