////
//  BottomSheetView.swift
//  bug-free-goggles
//
//  Created by Mac on 13/05/23.
//

import SwiftUI

struct BottomSheetView: View {
    @Environment(\.dismiss) var dismiss
    var onTapReschedule: () -> Void
    
    var body: some View {
        
        VStack(spacing: 20) {
            HStack {
                Text("Brunel's SS Great Britain")
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(.primary)

                Spacer()
                Button {
                    dismiss()
                } label: {
                    Circle()
                        .fill(Color(red: 0.949, green: 0.949, blue: 0.969))
                        .frame(width: 30, height: 30, alignment: .center)
                        .overlay {
                            Image(systemName: "xmark")
                                .font(.system(size: 12, weight: .bold, design: .rounded))
                                .foregroundColor(.secondary)
                        }
                }

            }
            VStack(spacing: 17) {
                Text("Great Western Dockyard, Gas Ferry Rd, Bristol BS1 6TY")
                    .font(.system(size: 17, weight: .regular))
                    .foregroundColor(.secondary)
                
                HStack {
                    Text("03:00 AM - 09:00 AM")
                        .font(.system(size: 15, weight: .regular))
                        .foregroundColor(.primary)
                    
                    Spacer(minLength: 0)
                    
                    Text("Reserved 4 Hours")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(Color(red: 0.263, green: 0.494, blue: 0.969))
                        .padding(.horizontal, 8)
                        .padding(.vertical, 3)
                        .background {
                            Capsule()
                                .fill(Color(red: 0.961, green: 0.98, blue: 1))
                        }
                }
            }
            
            VStack(spacing: 12) {
                Button {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        onTapReschedule()
                    }
                    dismiss()
                } label: {
                    Capsule()
                        .fill(Color(red: 0, green: 0.341, blue: 1))
                        .frame(height: 50)
                        .frame(maxWidth: .infinity)
                        .overlay {
                            Text("Re-Schedule")
                                .font(.system(size: 17, weight: .semibold, design: .rounded))
                                .foregroundColor(.white)
                        }
                }
                
                Button {
                    dismiss()
                } label: {
                    Capsule()
                        .fill(Color(red: 0.949, green: 0.949, blue: 0.969))
                        .frame(height: 50)
                        .frame(maxWidth: .infinity)
                        .overlay {
                            Text("No, thanks")
                                .font(.system(size: 17, weight: .semibold, design: .rounded))
                                .foregroundColor(.primary)
                        }
                }
            }
        }
        .padding(.horizontal)
    }
}


struct BottomSheetView_Previews: PreviewProvider {
    static var previews: some View {
        BottomSheetView {
            
        }
    }
}
