//
//  BasicSetUpView.swift
//  Totel (iOS)
//
//  Created by Hatesh Kumar on 08/05/2023.
//

import SwiftUI

struct BasicSetUpView: View {
    @ObservedObject var basicSetUpVM = BasicSetUpViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                switch basicSetUpVM.selectedTab {
                case 0: NameView()
                case 1: DateAndGenderView()
                case 2: ChooseImageView()
                default: HobbiesAndInterestView()
                }
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
            .padding(.top,40)
            .edgesIgnoringSafeArea(.top)
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        
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
        VStack(spacing: 12) {
            basicSetUpTopView(title: "Set-Up Basic", desc: "Kindly tell us about your self for better connection.")
            CustomTextField(placeholder: "First name", value: $basicSetUpVM.firstName,keyboardType: UIKeyboardType.namePhonePad)
                .padding(.top, 12)
            CustomTextField(placeholder: "Last name", value: $basicSetUpVM.lastName,keyboardType: UIKeyboardType.namePhonePad)
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
            
            HStack(spacing: 12) {
                CustomTextField(placeholder: "Day", value: $basicSetUpVM.day, keyboardType: .numberPad)
                CustomTextField(placeholder: "Month", value: $basicSetUpVM.month, keyboardType: .numberPad)
                CustomTextField(placeholder: "Year", value: $basicSetUpVM.year, keyboardType: .numberPad)
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
            .buttonStyle(PrimaryButtonStyle(isDisable: basicSetUpVM.dateContinueDisable))
            .disabled(basicSetUpVM.dateContinueDisable)
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
        .modal(present: $basicSetUpVM.showPhotoPicker, view: ImageChooserSheet())
    }
    
    func HobbiesAndInterestView() -> some View {
        VStack(spacing: 20) {
            basicSetUpTopView(title: "Hobbies & Interest", desc: "We’re ate final stage, choose maximum 5 of them.")
            
            HobbiesGridView(selectedHobbies: $basicSetUpVM.selectedHobbies)
            VStack(spacing: 10) {
                NavigationLink {
                    MainView()
                } label: {
                    Text("Continue")
                    }  .buttonStyle(PrimaryButtonStyle())  

                
                Button {
                    basicSetUpVM.navigateToMain()
                } label: {
                    Text("Skip")
                }
                .buttonStyle(BorderedButtonStyle())
            }
            Spacer()
        }
        .padding(.horizontal)
    }
    
    
    func ImageChooserSheet() -> some View {
        SheetContent {
            VStack(spacing: 12) {
                Button {
                    basicSetUpVM.openImagePicker()
                } label: {
                    Text("Take Photo")
                }
                .buttonStyle(BorderedButtonStyle())
                Button {
                    basicSetUpVM.openImagePicker(isPickFromGallery: true)
                } label: {
                    Text("Add from Gallery")
                }
                .buttonStyle(BorderedButtonStyle())
            }
            .padding()
            .padding(.bottom)
            .sheet(isPresented: $basicSetUpVM.openChooserSheet, onDismiss: {
                basicSetUpVM.showPhotoPicker = false
            }){
                ImagePicker(sourceType: basicSetUpVM.isPickFromGallery ? .photoLibrary : .camera, selectedImage: $basicSetUpVM.image){ image in
                    
                }
            }
        }
    }
}

struct BasicSetUpView_Previews: PreviewProvider {
    static var previews: some View {
        BasicSetUpView()
    }
}


struct DateItem: View {
    var title: String
    var isDateSelectes: Bool
    
    var body: some View {
        Text(title)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.vertical, 14)
            .padding(.horizontal)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.lightGray)
            )
    }
}
