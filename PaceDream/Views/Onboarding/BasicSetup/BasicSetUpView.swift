////
//  BasicSetUpView.swift
//  bug-free-goggles
//
//  Created by Mac on 01/05/23.
//

import SwiftUI

struct BasicSetUpView: View {
    @ObservedObject var basicSetUpVM = BasicSetUpViewModel.shared
     
    var body: some View {
        LoadingView(isShowing: $basicSetUpVM.isLoading) {
            content
        }
    }
    var content: some View {
        ZStack {
            switch basicSetUpVM.selectedTab {
            case 0: NameView()
            case 1: DateAndGenderView()
            case 2: ChooseImageView()
            default: HobbiesAndInterestView()
            }
        }
        //.toolbar(.hidden, for: .navigationBar)
        .navigationDestination(isPresented: $basicSetUpVM.openMainView) {
            MainView()
        }
        .sheet(isPresented: $basicSetUpVM.showDatePickerSheet) {
            DatePickerSheet(){ selectedDate in
                basicSetUpVM.date = selectedDate
            }
        }
    }
    
    func basicSetUpTopView(title: String, desc: String) -> some View {
        VStack(alignment: .leading, spacing: 4){
            Text(title)
                .font(.system(size: 28, weight: .bold))
            
            Text(desc)
                .font(.system(size: 15, weight: .regular))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    func NameView() -> some View {
        VStack(alignment: .leading, spacing: 12) {
            basicSetUpTopView(title: "Set-Up Basic", desc: "Kindly tell us about your self for better connection.")
            CustomTextField(placeholder: "First name", value: $basicSetUpVM.firstName)
                .padding(.top, 12)
            Text("First name should have more than 3 char")
                .font(.system(size: 13, weight: .regular))
                .foregroundColor(.red)
                .padding(.top, -8)
                .opacity(basicSetUpVM.fNameCheck ? 1 : 0)
            CustomTextField(placeholder: "Last name", value: $basicSetUpVM.lastName)
            Text("Last name should have more than 3 char")
                .font(.system(size: 13, weight: .regular))
                .foregroundColor(.red)
                .padding(.top, -8)
                .opacity(basicSetUpVM.lNameCheck ? 1 : 0)
            Button {
                basicSetUpVM.selectedTab = 1
            } label: {
                Text("Continue")
            }
            .buttonStyle(PrimaryButtonStyle(isDisable: basicSetUpVM.nameContinueDisable))
            .disabled(basicSetUpVM.nameContinueDisable)
            .padding(.top, 12)
            Spacer()
        }
        .padding(.horizontal)
    }
    
    func DateAndGenderView() -> some View {
        VStack(alignment: .leading){
            basicSetUpTopView(title: "Set-Up Basic", desc: "Kindly tell us about your self for better connection.")
            
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
            
            Button {
                basicSetUpVM.selectedTab = 2
            } label: {
                Text("Continue")
            }
            .buttonStyle(PrimaryButtonStyle())
            .padding(.top)
            Spacer()
        }
        .padding(.horizontal)
    }
    
    func ChooseImageView() -> some View {
        VStack(alignment: .center, spacing: 10) {
            basicSetUpTopView(title: "Set-Up Basic", desc: "Kindly tell us about your self for better connection.")
                .padding(.bottom, 14)
            if let image = basicSetUpVM.image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 164, height: 164)
                    .clipShape(Circle())
            } else {
                Image("personIcon")
                    .resizable()
                    .frame(width: 164, height: 164)
            }
            Button {
                if basicSetUpVM.image == nil {
                    basicSetUpVM.showPhotoPicker.toggle()
                } else {
                    basicSetUpVM.selectedTab = 3
                }
            } label: {
                if let _ = basicSetUpVM.image {
                    Text("Confirm profile photo")
                } else {
                    Text("Choose a photo")
                }
            }
            .buttonStyle(PrimaryButtonStyle())
            .padding(.top, 14)
            
            Button {
                basicSetUpVM.selectedTab = 3
            } label: {
                Text("Skip")
            }
            .buttonStyle(BorderedButtonStyle())
            Spacer()
        }
        .padding(.horizontal)
        .modal(present: $basicSetUpVM.showPhotoPicker,
               view:
                ImageChooserSheet(
                    selectedImage:  { basicSetUpVM.image = $0 },
                    dismiss: { basicSetUpVM.showPhotoPicker = false }
                )
        )
    }
    
    func HobbiesAndInterestView() -> some View {
        VStack(spacing: 20) {
            basicSetUpTopView(title: "Hobbies & Interest", desc: "We’re ate final stage, choose maximum 5 of them.")
            
            HobbiesGridView(selectedHobbies: $basicSetUpVM.selectedHobbies)
            VStack(spacing: 10) {
                Button {
                    basicSetUpVM.signUpWithEmail()
                } label: {
                    Text("Continue")
                }
                .buttonStyle(PrimaryButtonStyle())
                
                Button {
//                    basicSetUpVM.signUpWithPhone()
                    basicSetUpVM.isLoggedIn = true
                } label: {
                    Text("Skip")
                }
                .buttonStyle(BorderedButtonStyle())
            }
            Spacer()
        }
        .padding(.horizontal)
    }
}

struct BasicSetUpView_Previews: PreviewProvider {
    static var previews: some View {
        BasicSetUpView()
    }
}


struct DateItem: View {
    var title: String
//    var isDateSelectes: Bool
    
    var body: some View {
        Text(title)
            .font(.system(size: 17, weight: .regular))
            .frame(maxWidth: .infinity, alignment: .leading)
            .foregroundColor(.black)
            .padding(.vertical, 14)
            .padding(.horizontal)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.lightGray)
            )
    }
}
