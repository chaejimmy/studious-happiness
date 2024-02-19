////
//  NotLoggedInView.swift
//  bug-free-goggles
//
//  Created by Mac on 9/18/23.
//

import SwiftUI
import Lottie

struct NotLoggedInView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @EnvironmentObject var routerPath: RouterPath
    
    @ObservedObject var vm = OnboardingViewModel.shared
    @State var showCountryPicker: Bool = false
    @State var goToSetup: Bool = false
    
    
    var body: some View {
        LoadingView(isShowing: $vm.isLoading) {
            content
        }
    }
    
    var content: some View {
     
            GeometryReader { geo in
                VStack(alignment: .leading, spacing: 8) {
                    Button {
                        //dismiss()
                    } label: {
                        Image("backIcon")
                            .opacity(0.0)
                            .frame(width: 40, height: 40)
                            .offset(x: -10)
                    }
                    .padding(.top, 22)
                    
                    VStack(alignment: .leading, spacing: 20) {
                        
                        
                        HStack{
                            LottieView(lottieFile: "login")
                                .frame(width: 70, height: 100)
                                .padding(.leading, -12)
                            VStack(alignment: .leading, spacing: 4){
                                Text("Let’s start with phone")
                                    .font(.system(size: 23, weight: .bold))
                                HStack(spacing: 6) {
                                    Text(vm.authFlowType == .login ? "Don't have an account?" : "Already have an account?")
                                        .font(.system(size: 15, weight: .regular))
                                    Button {
                                        withAnimation {
                                            vm.authFlowType.loginSignUpToggle()
                                        }
                                    } label: {
                                        Text(vm.authFlowType == .login ? "Create an account" : "Sign In")
                                            .foregroundColor(.appPrimary)
                                            .font(.system(size: 15, weight: .semibold))
                                    }
                                }
                            }
                        }
                        
                        
                        HStack {
                            HStack(spacing: 0) {
                                ZStack {
                                    Rectangle()
                                        .foregroundColor(Color.clear)
                                        .frame(width: geo.size.width / 2.2, height: 40)
                                        .cornerRadius(100)
                                    
                                    Text("By Email")
                                        .font(
                                            Font.custom("Inter", size: 15)
                                                .weight(.semibold)
                                        )
                                        .foregroundColor(vm.isEmailSelected ? .white : .black)
                                }
                                .background(
                                    RoundedRectangle(cornerRadius: 100)
                                        .offset(x: vm.isEmailSelected ? 2 : (geo.size.width / 2.2) - 2, y: 0)
                                        .frame(width: geo.size.width / 2.2, height: 40)
                                        .foregroundColor(Color(red: 0.34, green: 0.31, blue: 0.98))
                                        .animation(.easeInOut(duration: 0.3))
                                        .shadow(radius: 10)
                                )
                                
                                
                                ZStack {
                                    Rectangle()
                                        .foregroundColor(Color.clear)
                                        .frame(width: geo.size.width / 2.2, height: 40)
                                        .cornerRadius(100)
                                    
                                    Text("By Phone")
                                        .font(
                                            Font.custom("Inter", size: 15)
                                                .weight(.semibold)
                                        )
                                        .foregroundColor(vm.isEmailSelected ? .black : .white)
                                }
                                
                                
                            }
                            .frame(height: 44)
                            .background(Color(red: 0.97, green: 0.98, blue: 0.98))
                            .cornerRadius(100)
                            .overlay(
                                RoundedRectangle(cornerRadius: 100)
                                    .inset(by: 0.5)
                                    .stroke(Color(red: 0.85, green: 0.88, blue: 0.9), lineWidth: 1)
                            )
                            .onTapGesture {
                                withAnimation {
                                    vm.isEmailSelected.toggle()
                                }
                            }
                        }.padding(.bottom)
                        
                        
                        HStack(spacing: 0) {
                            
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
                                        .frame(height: 50)
                                )
                                .frame(width: vm.isEmailSelected ? 0 : 100 , height: 50)
                                .clipped()
                            }.sheet(isPresented: $showCountryPicker) {
                                CountryPickerViewProxy { choosenCountry in
                                    vm.country = choosenCountry
                                }
                            }
                            
                            
                            TextField( vm.isEmailSelected ?  "Enter your email" : "Enter your mobile phone" , text:  vm.isEmailSelected ? $vm.email : $vm.mobileNo)
                                .keyboardType( vm.isEmailSelected ? .emailAddress : .numberPad)
                                .textInputAutocapitalization(.never)
                                .padding(.horizontal)
                                .padding(.vertical, 14)
                                .background(
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(Color.lightGray)
                                )
                            
                            
                            
                        }
                        
                        ZStack(alignment: .trailingLastTextBaseline) {
                            if vm.isPasswordVisible {
                                SecureField("Password", text: $vm.password)
                                    .autocapitalization(.none)
                                    .textInputAutocapitalization(.never)
                                    .padding(.horizontal)
                                    .padding(.vertical, 14.5)
                                    .background(
                                        RoundedRectangle(cornerRadius: 12)
                                            .fill(Color.lightGray)
                                    )
                            } else {
                                TextField("Password", text: $vm.password)
                                    .autocapitalization(.none)
                                    .textInputAutocapitalization(.never)
                                    .padding(.horizontal)
                                    .padding(.vertical, 14)
                                    .background(
                                        RoundedRectangle(cornerRadius: 12)
                                            .fill(Color.lightGray)
                                    )
                            }
                            
                            
                            Button(action: {
                                vm.isPasswordVisible.toggle()
                            }) {
                                Image(systemName: vm.isPasswordVisible ? "eye.slash" : "eye")
                                    .padding(.horizontal)
                                    .foregroundColor(.gray700)
                            }
                        }
                        
                        
                        if vm.authFlowType == .signup {
                            ZStack(alignment: .trailingLastTextBaseline) {
                                if vm.isPasswordVisible {
                                    SecureField("Repeat Password", text: $vm.confirmPassword)
                                        .autocapitalization(.none)
                                        .textInputAutocapitalization(.never)
                                        .padding(.horizontal)
                                        .padding(.vertical, 14.5)
                                        .background(
                                            RoundedRectangle(cornerRadius: 12)
                                                .fill(Color.lightGray)
                                        )
                                } else {
                                    TextField("Repeat Password", text: $vm.confirmPassword)
                                        .autocapitalization(.none)
                                        .textInputAutocapitalization(.never)
                                        .padding(.horizontal)
                                        .padding(.vertical, 14)
                                        .background(
                                            RoundedRectangle(cornerRadius: 12)
                                                .fill(Color.lightGray)
                                        )
                                }
                                
                                
                                Button(action: {
                                    vm.isPasswordVisible.toggle()
                                }) {
                                    Image(systemName: vm.isPasswordVisible ? "eye.slash" : "eye")
                                        .padding(.horizontal)
                                        .foregroundColor(.gray700)
                                }
                            }
                        }
                        
                        
                        if vm.authFlowType == .login {
                            Button {
                                if vm.authFlowType == .login{
                                    if vm.isEmailSelected {
                                        vm.loginWithEmail()
                                    } else {
                                        vm.loginWithPhone()
                                    }
                                    
                                }else{
                                    goToSetup = true
                                }
                            
                               
                                //VerificationView(vm.authFlowType: vm.authFlowType)
                            } label: {
                                Text("Continue")
                            }
                            
                            .buttonStyle(PrimaryButtonStyle(isDisable: vm.formValidation))
                            .disabled(vm.formValidation)
                        }else{
                            Button {
                                if vm.isEmailAvailable {
                                    routerPath.navigate(to: .basicSetUp)
                                } else {
//                                    vm.checkEmail { isAvailable in
//                                               if isAvailable {
//                                                   
//                                               }
//                                           }
                                    userDefaults.userInfo = ["email" : vm.email, "password": vm.password]
                                    
                                    routerPath.navigate(to: .basicSetUp)

                                }
                                //VerificationView(vm.authFlowType: vm.authFlowType)
                            } label: {
                                Text("Continue")
                            }

                            .buttonStyle(PrimaryButtonStyle(isDisable: vm.formValidation))
                            .disabled(vm.formValidation)
                        }

                        
                        
                      
                        
                        //                    Button {
                        //                        vm.showVerification = true
                        //                        //vm.sendOtp()
                        //                    } label: {
                        //                        Text("Continue")
                        //                    }
                        //                    .buttonStyle(PrimaryButtonStyle(isDisable: vm.mobileValidation))
                        //                    .disabled(vm.mobileValidation)
                        
                        if vm.authFlowType == .signup {
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
//                            .navigationDestination(isPresented: $goToSetup) {
//                                BasicSetUpView()
//                            }
                .ignoresSafeArea()
                
                //.toolbar(.hidden, for: .navigationBar)
            }
        
    }
    
}

struct NotLoggedInView_Previews: PreviewProvider {
    static var previews: some View {
        NotLoggedInView()
    }
}



struct LottieView: UIViewRepresentable {
    let lottieFile: String
    
    let animationView = LottieAnimationView()
    
    func makeUIView(context: Context) -> some UIView {
        let view = UIView(frame: .zero)
        
        animationView.animation = LottieAnimation.named(lottieFile)
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.play()
        
        view.addSubview(animationView)
        
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        animationView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}
