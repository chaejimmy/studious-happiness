//
//  LookForView.swift
//  Totel
//
//  Created by Jaykrushna Solanki on 24/08/23.
//

import SwiftUI
import SwiftUIChipGroup

struct LookOption: Identifiable {
    var id: UUID
    var title: String
    var image: String
    
    init(id: UUID = UUID(), title: String, image: String) {
        self.id = id
        self.title = title
        self.image = image
    }
    
    
}

final class LookForViewModel: ObservableObject {
   
    var selectionOptions = [
        LookOption(title: "Everyone", image: "ImgEveryone"),
        LookOption(title: "Men", image: "ImgMen"),
        LookOption(title: "Women", image: "ImgWomen"),
    ]
    
    
}

struct LookForView: View {
    
    @StateObject
    private var vm = LookForViewModel()
    
    var body: some View {

        ScrollView {
            
            VStack {
                
                VStack(spacing: 20.0) {
                    
                    ForEach(vm.selectionOptions) { option in
                        NavigationLink {
                            DestinationView()
                        } label: {
                            LookOptionView(option: option)
                        }
                        .padding()
                       
                    }
                    
                }
                .padding()
                
              
                
                
                
                
            }
            
        }
        .navigationTitle("I am looking for")
    }
}

struct LookForView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            LookForView()
        }
    }
}
