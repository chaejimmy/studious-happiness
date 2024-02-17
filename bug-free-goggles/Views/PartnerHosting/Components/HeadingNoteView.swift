////
//  HeadingNoteView.swift
//  bug-free-goggles
//
//  Created by Mac on 01/06/23.
//

import SwiftUI

struct HeadingNoteView: View {
    @Binding var heading: String
    @Binding var note: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            VStack(alignment: .leading, spacing: 10){
                Text("Heading").style(.subheadline1)
                TextField("", text: $heading)
                    .style(.subheadline)
                    .padding(12)
                    .background(Color.secondaryLightGray)
            }
            .padding(.top, 4)
            
            VStack(alignment: .leading, spacing: 10){
                Text("Note").style(.subheadline1)

                TextEditor(text: $note)
                    .style(.subheadline)
                    .frame(height: 145, alignment: .top)
                    .multilineTextAlignment(.leading)
                    .lineLimit(nil)
                    .lineSpacing(2)
                    .padding(12)
                    .scrollContentBackground(.hidden)
                    .background(Color.secondaryLightGray)
            }
            Spacer()
        }
    }
}

struct HeadingNoteView_Previews: PreviewProvider {
    static var previews: some View {
        HeadingNoteView(heading: .constant("House Ariena, United Kingdom"), note: .constant("You'll have a great time at this comfortable place to stay."))
    }
}
