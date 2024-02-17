////
//  DestinationView.swift
//  bug-free-goggles
//
//  Created by Mac on 9/16/23.
//

import SwiftUI



//
//  LookForView.swift
//  Totel
//
//  Created by Jaykrushna Solanki on 24/08/23.
//

import SwiftUI
import SwiftUIChipGroup

final class DestinationViewModel: ObservableObject {
    
    @Published
    var selectedDestinations: [String]!
    
    @Published
    var newDesination: String = ""
    
    let items = [
        ChipItem(name: "Bristol"),
        ChipItem(name: "London"),
        ChipItem(name: "Virginia"),
        ChipItem(name: "New York"),
        ChipItem(name: "Los Angeles"),
        ChipItem(name: "Seattle"),
        ChipItem(name: "San Francisco"),
    ]
    
    
}

struct DestinationView: View {
    
    @StateObject
    private var vm = DestinationViewModel()
    
    var body: some View {

        ScrollView {
            
            VStack {
                
                
//                VStack(alignment: .leading) {
//                    Text("Select your destination")
//                        .font(.largeTitle)
//                    .fontWeight(.bold)
//                    Text("Select your destination")
//                        .foregroundColor(.secondary)
//
//                }
//                .padding([.top, .bottom])
                
                ChipGroup(
                    chips: vm.items,
                    width: UIScreen.main.bounds.width - 60,
                    selection: .multi,
                    selectedBackground: Capsule().fill(Color.darkIndigo),
                    deselectedBackground: Capsule().fill(Color("AliceBlue")),
                    selectedTextColor: .white,
                    deselectedTextColor: Color.gray,
                    font: .system(size: 20, weight: .medium, design: .default)
                )
                
                TextField("Enter your destination", text: $vm.newDesination)
                    .padding()
                    .background {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color("AliceBlue"))
                    }
                    .padding()
                
                NavigationLink {
                    PersonPagesView()
                } label: {
                    Text("Continue")
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background {
                            RoundedRectangle(cornerRadius: 30)
                        }
                }
                .padding()
                
                
            }
            
        }
        .navigationTitle("Select your destination")
    }
}

struct DestinationView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            DestinationView()
        }
    }
}
