////
//  SignOutSheet.swift
//  bug-free-goggles
//
//  Created by Mac on 08/05/23.
//

import SwiftUI

struct SignOutSheet: View {
    let dismissAction: () -> Void
    @State var shouldShowOnboarding = false
    var body: some View {
        SheetContent {
            VStack(spacing: 12) {
                HStack {
                    Text("Are you sure you want to Sign Out?")
                        .font(.system(size: 17, weight: .semibold))
                    Spacer()
                    CloseButtonView {
                        dismissAction()
                    }
                }
                
                Button {
                    shouldShowOnboarding.toggle()
                } label: {
                    Text("Yes, Sign Out")
                }
                .buttonStyle(PrimaryButtonStyle(background: .red))
                .padding(.top, 12)
                
                Button {
                    dismissAction()
                } label: {
                    Text("Cancel")
                }
                .buttonStyle(PrimaryButtonStyle(foregroundColor: .black, background: .darkWhite))
            }
            .padding()
            .padding(.bottom)
        }
        .navigationDestination(isPresented: $shouldShowOnboarding) {
            OnboardingView()
            
        }
    }
}

struct SignOutSheet_Previews: PreviewProvider {
    static var previews: some View {
        SignOutSheet(){}
    }
}
