////
//  CounterView.swift
//  bug-free-goggles
//
//  Created by Mac on 9/4/23.
//

import SwiftUI

struct CounterView: View {
    var lable: String
    var subLable: String?
    let action: (Int) -> Void
    
    @State private var adultsCount = 0
    
    
    
    var body: some View {
        HStack(spacing: 5) {
            VStack(alignment: .leading) {
                Text(self.lable)
                    .fontWeight(.medium)
                    .foregroundColor(.black)
                
                if subLable != nil{
                    Text(self.subLable!)
                        .font(.caption)
                        .foregroundColor(.darkGray)
                }
               
            }
            Spacer()
            
            NumberInputView(count: $adultsCount){count in
                action(count)
            }
        }
        .padding(.bottom)
        
    }
}

struct NumberInputView: View {
    @Binding var count: Int
    let action: (Int) -> Void
    
    var body: some View {
        HStack(spacing: 0) {
            Button(action: {
                if count > 0 {
                    count -= 1
                    action(count)
                }
            }) {
                Image(systemName: "minus")
                    .font(.system(size: 10))
                    .foregroundColor(.black)
                    .frame(width: 24, height: 24)
                    .background(Color.white)
                    .clipShape(Circle())
                    .overlay(
                        Circle()
                            .stroke(.black, lineWidth: 1)
                    )
                    .padding(.trailing, 4)
            }
            
            Text("\(count)")
                .font(.headline)
                .foregroundColor(.black)
                .frame(width: 24)
            
            Button(action: {
                count += 1
                action(count)
            }) {
                Image(systemName: "plus")
                    .font(.system(size: 10))
                    .foregroundColor(.black)
                    .frame(width: 24, height: 24)
                    .background(Color.white)
                    .clipShape(Circle())
                    .overlay(
                        Circle()
                            .stroke(.black, lineWidth: 1)
                    )
                    .padding(.leading, 4)
            }
        }
    }
    
}

struct CounterView_Previews: PreviewProvider {
    static var previews: some View {
        CounterView(lable: "Adult", subLable: "Ages 12 and above") { count in
            print(count)
        }
    }
}
