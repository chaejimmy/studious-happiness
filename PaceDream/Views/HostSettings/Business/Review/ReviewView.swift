//
//  ReviewView.swift
//  Totel (iOS)
//
//  Created by Don Bouncy on 02/09/2023.
//

import SwiftUI

struct ReviewView: View {
    @ObservedObject var businessVM: BusinessViewModel
    
    var body: some View{
        ScrollView(showsIndicators: false) {
            VStack(spacing: 20) {
                ForEach(businessVM.reviews, id: \.createdAt){ review in
                    ReviewCard(review: review)
                }
            }
            .padding()
        }
    }
}
