////
//  CompatibleNoteView.swift
//  bug-free-goggles
//
//  Created by Mac on 11/05/23.
//

import SwiftUI

struct CompatibleNoteView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Compatible with")
                .font(.system(size: 17, weight: .semibold))
            
            GridArrangeView(list: PreviewData.compatibleDescs)
            
            Text("Note")
                .font(.system(size: 17, weight: .semibold))
                .padding(.top, 8)
            
            Text("I’m looking for a roommate in a social house share with people a similar age to me, or a group to buddy up with and find somewhere. I enjoy drawing and painting, as well as watching films and listening to podcasts.")
                .font(.system(size: 17, weight: .regular))
                .foregroundColor(.secondaryGray)
        }
        .padding()
        .background(Color.white)
    }
}

struct CompatibleNoteView_Previews: PreviewProvider {
    static var previews: some View {
        CompatibleNoteView()
    }
}
