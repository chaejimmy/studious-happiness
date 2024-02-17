//
//  PrivacyView.swift
//  Totel
//
//  Created by Jaykrushna Solanki on 24/08/23.
//

import SwiftUI
import MarkdownUI

struct PrivacyView: View {
    
    private var content = #"""
    Lorem ipsum dolor amet, consectetur adipiscing elit
    
    > Morbi et rutrum lorem. Proin malesuada hendrerit ultrices. Nam justo justo, ultricies at aliquam eu, sodales quis enim. Donec semper lorem est, eget iaculis eros pretium et. Fusce eu placerat mi. Quisque vitae massa et lacus bibendum sodales eu sed dolor. Morbi et imperdiet dolor. Aliquam et elementum nisi.

    * Vivamus sed nisl nec mauris sagittis porttitor.
    * Curabitur eu augue sit amet sapien congue volutpat ac at lectus.
    * Sed at vestibulum massa.
    * Donec condimentum viverra dolor, at dictum risus imperdiet quis.
    * Ut mattis a felis at viverra.
    * Nunc non mauris quam.
    * Suspendisse luctus sem ornare, condimentum eros quis, convallis ante.
    
    ### Tortor augue rhoncus ex
    
    Vestibulum fermentum, magna in ultricies sollicitudin, tortor augue rhoncus ex, sed molestie nulla nibh in enim. Mauris at interdum ex. Phasellus fermentum est eu ante lacinia consequat. Vivamus quis porta sapien, quis commodo diam. Phasellus luctus nisi ex, at aliquam orci tincidunt sed. Vestibulum bibendum mauris eros, quis aliquam tortor vestibulum id. Cras sollicitudin commodo arcu, vel faucibus ipsum condimentum non. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Nullam eget condimentum sem. Vivamus maximus turpis laoreet malesuada varius. Nullam id ante non ex consectetur auctor. Fusce fringilla gravida rhoncus. Vestibulum finibus id lacus ac auctor. In in elementum urna. Donec fermentum tellus id tortor cursus cursus.
    
    Vivamus sed nisl nec mauris sagittis porttitor. Curabitur eu augue sit amet sapien congue volutpat ac at lectus. Sed at vestibulum massa. Donec condimentum viverra dolor, at dictum risus imperdiet quis. Ut mattis a felis at viverra. Nunc non mauris quam. Suspendisse luctus sem ornare, condimentum eros quis, convallis ante. Integer viverra augue at ipsum accumsan porta.
    
    """#
    
    var body: some View {
        ScrollView {
            Markdown(content)
                .padding()
            .navigationTitle("Privacy Policy")
        }
    }
}

struct PrivacyView_Previews: PreviewProvider {
    static var previews: some View {
        PrivacyView()
    }
}
