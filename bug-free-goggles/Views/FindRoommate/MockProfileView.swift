//
//  ProfileViewView.swift
//  Totel
//
//  Created by Jaykrushna Solanki on 24/08/23.
//

import SwiftUI

struct MockProfileView: View {
    var body: some View {
        VStack {
            NavigationLink {
                TermsView()
            } label: {
                Text("Terms of Service")
                    .fontWeight(.medium)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background {
                        RoundedRectangle(cornerRadius: 30)
                            .fill(Color.darkIndigo)
                    }
            }
            .padding()
            
            NavigationLink {
                PrivacyView()
            } label: {
                Text("Privacy Policy")
                    .fontWeight(.medium)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background {
                        RoundedRectangle(cornerRadius: 30)
                            .fill(Color.darkIndigo)
                    }
            }
            .padding()
            
        }
    }
}

struct MockProfileView_Previews: PreviewProvider {
    static var previews: some View {
        MockProfileView()
    }
}
