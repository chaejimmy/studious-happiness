////
//  SignInView.swift
//  bug-free-goggles
//
//  Created by Mac on 01/05/23.
//

import SwiftUI
import CountryPicker

struct SignInView: View {
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var vm = OnboardingViewModel.shared
    @State var authFlowType: AuthFlowType = .signup
    @State var showCountryPicker: Bool = false
    
    var body: some View {
       
            LoadingView(isShowing: $vm.isLoading) {
                content
            }
  
     
    }
    
    var content: some View {
        NavigationStack{
            VStack(alignment: .leading, spacing: 8) {
                Button {
                    dismiss()
                } label: {
                    Image("backIcon")
                        .frame(width: 40, height: 40)
                        .offset(x: -10)
                }
                .padding(.top, 22)
                
                VStack(alignment: .leading, spacing: 20) {
                    VStack(alignment: .leading, spacing: 4){
                        Text("Let’s start with phone")
                            .font(.system(size: 28, weight: .bold))
                        HStack(spacing: 6) {
                            Text(authFlowType == .login ? "Don't have an account?" : "Already have an account?")
                                .font(.system(size: 15, weight: .regular))
                            Button {
                                withAnimation {
                                    authFlowType.loginSignUpToggle()
                                }
                            } label: {
                                Text(authFlowType == .login ? "Create an account" : "Sign In")
                                    .foregroundColor(.appPrimary)
                                    .font(.system(size: 15, weight: .semibold))
                            }
                        }
                    }
                    
                    HStack(spacing: 12) {
                        Button {
                            showCountryPicker = true
                        } label: {
                            HStack {
                                Image(uiImage: vm.country.flag ?? UIImage())
                                    .resizable()
                                    .frame(width: 28, height: 28)
                                    .clipShape(Circle())
                                Text("(\(vm.countryCode))")
                                    .font(.system(size: 13, weight: .semibold))
                                    .foregroundColor(.black)
                            }
                            .padding(8)
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(Color.lightGray)
                            )
                        }.sheet(isPresented: $showCountryPicker) {
                            CountryPickerViewProxy { choosenCountry in
                                vm.country = choosenCountry
                            }
                        }
                        
                        
                        TextField("Enter your mobile phone", text: $vm.mobileNo)
                            .keyboardType(.numberPad)
                            .padding(.horizontal)
                            .padding(.vertical, 14)
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(Color.lightGray)
                            )
                    }
                    
                    TextField("Enter your email", text: $vm.email)
                        .keyboardType(.emailAddress)
                        .textInputAutocapitalization(.never)
                        .padding(.horizontal)
                        .padding(.vertical, 14)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.lightGray)
                        )
                    
                    
                 
                    
                    Button {
                        vm.showVerification = true
                        //vm.sendOtp()
                    } label: {
                        Text("Continue")
                    }
                    .buttonStyle(PrimaryButtonStyle(isDisable: vm.mobileValidation))
                    .disabled(vm.mobileValidation)
                    
                    if authFlowType == .signup {
                        Text("By continuing, you acknowledge that you have read and understood, and agree to Totel’s Terms of Service and Privacy Policy.")
                            .font(.system(size: 13, weight: .regular))
                            .foregroundColor(.secondaryGray)
                    }
                }
                
                Spacer()
                Button {
                    vm.userAuthService.signIn { success, token  in
                        
                    }
                } label: {
                    HStack(spacing: 10) {
                        Image("googleIcon")
                        Text("Continue with Google")
                    }
                }
                .buttonStyle(BorderedButtonStyle())
                .padding(.bottom)
            }
            .padding()
            .navigationDestination(isPresented: $vm.showVerification) {
                VerificationView(authFlowType: authFlowType)
            }
            .ignoresSafeArea()
            .toolbar(.hidden, for: .navigationBar)
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
