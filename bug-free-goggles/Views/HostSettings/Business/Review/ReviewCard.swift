//
//  ReviewCard.swift
//  Totel (iOS)
//
//  Created by Alexander Boakye on 02/09/2023.
//

import SwiftUI

struct ReviewCard: View {
    var review: ReviewModel
    @State var showMore = false
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .center) {
                Image(review.userImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                
                VStack(alignment: .leading) {
                    Text(review.name)
                        .bold()
                        .padding(.bottom, 2)
                    
                    RatingsView(rating: review.rating)
                    .padding(.bottom, 2)
                    
                    Text(review.bookingNumber)
                        .font(.subheadline)
                        .foregroundStyle(.gray)   
                }
                
                Spacer()
                
                ZStack(alignment: .center) {
                    Circle()
                        .trim(from: 0, to: 0.5)
                        .fill(.blue)
                        .frame(width: 40, height: 40)
                        .rotationEffect(Angle(degrees: 90))
                    
                    Button {
                        withAnimation {
                            showMore.toggle()
                        }
                    } label: {
                        Image(systemName: !showMore ? "chevron.down" : "chevron.up")
                            .resizable()
                            .font(.body.bold())
                            .frame(width: 8, height: 8)
                            .foregroundStyle(.white)
                    }
                    .offset(x: -8, y: 1)
                }
                .offset(x: 36)
            }
            .padding(.bottom, 2)
            
            if showMore{
                Text(review.review)
                    .font(.footnote)
                    .foregroundStyle(.gray)
                    .padding(.bottom)
                
                HStack(spacing: 30) {
                    InsightIcons(iconName: "eye.fill", insight: review.views)
                    InsightIcons(iconName: "square.and.arrow.up.fill", insight: review.shares)
                    Spacer()
                    Text(review.timeElapsed)
                        .font(.footnote)
                        .foregroundStyle(.gray)
                }
            }
        }
        .padding()
        .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(.white)
                    .shadow(color: .black.opacity(0.05), radius: 10, x: 4, y: 10)
                    .shadow(color: .black.opacity(0.05), radius: 10, x: -4, y: -10)
            
        )
    }
}
struct InsightIcons: View {
    let iconName: String
    let insight: Int
    var body: some View {
        HStack {
            Image(systemName: iconName)
                .font(.caption)
                .foregroundStyle(.gray)
            
            Text("\(insight)")
                .font(.caption)
                .foregroundStyle(.gray)
        }
    }
}
