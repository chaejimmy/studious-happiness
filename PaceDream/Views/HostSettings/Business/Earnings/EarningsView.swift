//
//  EarningsView.swift
//  Totel (iOS)
//
//  Created by Alexander Boakye on 07/09/2023.
//

import SwiftUI

struct EarningsView: View {
    let earnings = [100, 0, 0, 0]
    var body: some View {
        Group{
            HStack {
                VStack(alignment: .leading) {
                    Text("$100 earned in 2023")
                        .font(.title.bold())
                        .padding(.bottom, 3)
                    
                    Text("All earnings adjustments included")
                        .font(.callout)
                        .foregroundColor(.gray)
                }
                Spacer()
                Button {
                    
                } label: {
                    Image("filterIcon")
                        .renderingMode(.template)
                        .foregroundColor(.white)
                        .frame(width: 40, height: 40)
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color.appBlue))
                }
            }
            .padding()
            
            ZStack{
                VStack(spacing: 20) {
                    ForEach((0...4).reversed(), id: \.self){ i in
                        VStack(spacing: 0) {
                            HStack(alignment: .center){
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(i == 0 ? Color.appBlue : Color.appBlue.opacity(0.11), lineWidth: i == 0 ? 3 : 1)
                                    .frame(width: UIScreen.main.bounds.width - 100, height: 1)
                                Spacer()
                                Text("$\(i * 1000)")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            .padding(.horizontal)
                            
                            if i == 0{
                                HStack {
                                    Text("Jan")
                                    Spacer()
                                    Text("Jul")
                                    Spacer()
                                }
                                .padding(.horizontal)
                            }
                        }
                        .foregroundColor(.appBlue)
                    }
                }
            }
            .frame(height: 238)
            .background(Color(red: 0.97, green: 0.98, blue: 1))
            
            VStack(alignment: .leading){
                ForEach(0...3, id: \.self){
                    ExpensesBreakdown(index: $0, earning: earnings[$0])
                }
            }
            .padding()
        }
    }
}
