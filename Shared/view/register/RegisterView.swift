//
//  RegisterVoew.swift
//  Totel (iOS)
//
//  Created by Hatesh Kumar on 08/05/2023.
//


import SwiftUI

struct RegisterView: View {
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var vm = AuthiewModel.shared
    @State var isForLogin: Bool = false
    @State var showCountryPicker: Bool = false
    
    
    var body: some View {
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
                        Text(isForLogin ? "Don't have an account?" : "Already have an account?")
                            .font(.system(size: 15, weight: .regular))
                        Button {
                            withAnimation {
                                isForLogin.toggle()
                            }
                        } label: {
                            Text(isForLogin ? "Create an account" : "Sign In")
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
                            Image(uiImage: UIImage())
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
                    }.sheet(isPresented: $showCountryPicker) {
                      
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
                Button {
                    vm.showVerification = true
                } label: {
                    Text("Continue")
                }
                .buttonStyle(PrimaryButtonStyle(isDisable: vm.mobileValidation))
                .disabled(vm.mobileValidation)
                
                if !isForLogin {
                    Text("By continuing, you acknowledge that you have read and understood, and agree to Totel’s Terms of Service and Privacy Policy.")
                        .font(.system(size: 13, weight: .regular))
                        .foregroundColor(.secondaryGray)
                }
            }
            
            Spacer()
            Button {
                
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
        .ignoresSafeArea()
        .navigationBarBackButtonHidden(true)
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
