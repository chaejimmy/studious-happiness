//
//  VerificationView.swift
//  Totel (iOS)
//
//  Created by Hatesh Kumar on 08/05/2023.
//

import SwiftUI

struct VerificationView: View {
    @ObservedObject var vm = AuthiewModel.shared
    @AppStorage("isLoggedIn") var isLoggedIn = false
    @FocusState var isKeyboardShowing: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            VStack(alignment: .leading, spacing: 4){
                Text("Verification")
                    .font(.system(size: 28, weight: .bold))
                
                Text("Enter the 6-digit code sent to ")
                    .font(.system(size: 15, weight: .regular))
                + Text("\("+1") \(vm.mobileNo)")
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundColor(.appPrimary)
            }
            HStack {
                ForEach(0..<vm.otpLength, id: \.self) { index in
                    OTPTextBox(index)
                }
            }
            .background(){
                TextField("", text: $vm.otpText.limit(vm.otpLength))
                    .keyboardType(.numberPad)
                    .textContentType(.oneTimeCode)
                    .frame (width: 1, height: 1)
                    .opacity (0.001)
                    .blendMode (.screen)
                    .focused($isKeyboardShowing)
            }
            .contentShape(Rectangle())
            .padding(.top, 12)
            .onTapGesture {
                isKeyboardShowing.toggle()
            }
            
            
            Button {
//                vm.sendOTPAndTimerStart()
            } label: {
                Text("I haven’t received a code \(vm.resendOtpEnable ? "" : timerString(seconds: vm.timeElapsed))")
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundColor(vm.resendOtpEnable ? .black : .secondaryGray)
                    .padding(.horizontal)
                    .padding(.vertical, 10)
                    .background(
                        Capsule()
                            .fill(Color.lightGray)
                    )
            }
            .disabled(!vm.resendOtpEnable)
            
            
            NavigationLink(destination: SetPasswordView(), label:
                             {
                
                Text("Confirm")
                
                
                     
            })
                .buttonStyle(
                             PrimaryButtonStyle(foregroundColor: vm.confirmOTPEnable ? .white : .secondaryGray, background: vm.confirmOTPEnable ? .appPrimary : .darkWhite))
                                 .disabled(!vm.confirmOTPEnable)

            Spacer()
        }
        .padding(.top, -80) // Adjust the value as needed
        .padding(.horizontal)
        .navigationBarBackButtonHidden(true)
        
        
    }
    
    @ViewBuilder
    func OTPTextBox(_ index: Int) -> some View {
        ZStack {
            if vm.otpText.count > index {
                let startIndex = vm.otpText.startIndex
                let charIndex = vm.otpText.index(startIndex, offsetBy: index)
                let charToString = String(vm.otpText[charIndex])
                Text (charToString)
            } else {
                 Text(" ")
            }
        }
        .frame(width: 54, height: 60)
        .background {
            let status = (isKeyboardShowing && vm.otpText.count == index)
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.appPrimary, style: StrokeStyle(lineWidth: status ? 1 : 0))
        }
        .background {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.lightGray)
        }
        .frame(maxWidth: .infinity)
    }
    
    func timerString(seconds:Int) -> String {
        return String(format: "%02d:%02d", 0, seconds)
    }
}

struct VerificationView_Previews: PreviewProvider {
    static var previews: some View {
        VerificationView()
    }
}


extension Binding where Value == String{
    func limit(_ length: Int) -> Self {
        if self.wrappedValue .count > length {
            DispatchQueue.main.async {
                self.wrappedValue = String(self.wrappedValue.prefix(length))
            }
        }
        return self
    }
}
