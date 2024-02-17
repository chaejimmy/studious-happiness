////
//  VerificationView.swift
//  bug-free-goggles
//
//  Created by Mac on 01/05/23.
//

import SwiftUI

struct VerificationView: View {
    
    @Environment(\.dismiss) var dismiss

    @ObservedObject var vm = OnboardingViewModel.shared
    var authFlowType: AuthFlowType
    @FocusState var isKeyboardShowing: Bool
    
    var body: some View {
        LoadingView(isShowing: $vm.isLoading) {
            content
        }
    }
    
    var content: some View {
        VStack(alignment: .leading, spacing: 12) {
            VStack(alignment: .leading, spacing: 4){
                
                HStack {
                    CircleButton(size: 40, backgroundColor: .darkWhite) {
                        IconView(image: "chevron_left", size: 24)
                    } action: {
                       dismiss()
                    }.padding(.trailing,10)
                    
                    Text("Verification")
                        .font(.system(size: 28, weight: .bold))
                }
                
                Text("Enter the 6-digit code sent to ")
                    .font(.system(size: 15, weight: .regular))
                + Text("\(vm.country.dialingCode ?? "+1") \(vm.mobileNo)")
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
                vm.sendOTPAndTimerStart()
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
            Button {
                //vm.verifyOtp()
                //vm.showPasswordView = true
                BasicSetUpViewModel.shared.isLoggedIn = true
                
            } label: {
                Text("Confirm")
            }
            .buttonStyle(
                PrimaryButtonStyle(foregroundColor: vm.confirmOTPEnable ? .white : .secondaryGray, background: vm.confirmOTPEnable ? .appPrimary : .darkWhite))
            .disabled(!vm.confirmOTPEnable)
            .padding(.top, 12)
            Spacer()
        }
        .padding(.horizontal)
        .navigationDestination(isPresented: $vm.showPasswordView){
            SetPasswordView(authFlowType: authFlowType)
        }
        .toolbar(.hidden, for: .navigationBar)
        .toolbar {
            ToolbarItem(placement: .keyboard) {
                Button("Done"){
                    isKeyboardShowing.toggle()
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
        }
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
        VerificationView(authFlowType: .signup)
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
