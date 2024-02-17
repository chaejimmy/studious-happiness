//
//  PersonCard.swift
//  Totel
//
//  Created by Jaykrushna Solanki on 24/08/23.
//

import SwiftUI

struct PersonBio: Identifiable {
    var id: UUID
    var name: String
    var age: String
    var income: String
    var available: String
    var info: String
    var image: String
    
    init(id: UUID = UUID(),
         name: String,
         age: String,
         income: String,
         available: String,
         info: String,
         image: String) {
        self.id = id
        self.name = name
        self.age = age
        self.income = income
        self.available = available
        self.info = info
        self.image = image
    }
}

extension PersonBio {
    var bioImage: Image {
        Image(image)
    }
}

extension PersonBio {
    static let dummy = [
        PersonBio(name: "Heeshi",
                  age: "25",
                  income: "$300 - $400 / Month",
                  available: "28 Aug 2023",
                  info: "Looking for 1-2 roommates for a place in Manchester city center (wanting to move in around August time.",
                 image: "person1"),
        PersonBio(name: "John",
                  age: "27",
                  income: "$700 - 6400 / Month",
                  available: "30 Aug 2023",
                  info: "Looking for 1-2 roommates for a place in Manchester city center (wanting to move in around August time.",
                  image: "person2"),
    ]
}

struct PersonCard: View {
    let bio: PersonBio
    
    var gradient: LinearGradient {
        .init(
            gradient: Gradient(colors: [.black.opacity(0.6), .black.opacity(0)]),
            startPoint: .bottom,
            endPoint: .top)
    }
    
    var body: some View {
        bio.bioImage
            .resizable()
            .scaledToFill()
            .cornerRadius(20.0)
            .overlay {
                ZStack(alignment: .bottomLeading) {
                    gradient
                    VStack(alignment: .leading, spacing: 10.0) {
                        HStack {
                            Text(bio.name)
                                .font(.title)
                                .bold()
                            Text("\(bio.age) y")
                                .font(.title)
    
                        }
                        
                        Text(bio.income)
                            .font(.headline)
                        
                        Text("Available from - \(bio.available)")
                            .font(.headline)
                            
                        
                        Text(bio.info)
                        
                        HStack {
                            Spacer()
                            Button(action: {}) {
                                HStack {
                                    Image("IconNotLikeArrow")
                                    Image("IconNotLike")
                                }
                            }
                            
                            Button(action: {}) {
                                HStack {
                                    Image("IconLike")
                                    Image("IconLikeArrow")
                                }
                            }
    
                            Spacer()
                        }
                    }
                    .padding()
                }
                .cornerRadius(20.0)
                .foregroundColor(.white)
            }
    }
}

struct PersonCard_Previews: PreviewProvider {
    static var previews: some View {
        PersonCard(bio: .dummy[0])
    }
}
