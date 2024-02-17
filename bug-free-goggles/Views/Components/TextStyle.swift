//
//  TextStyle.swift
//  bug-free-goggles
//
//  Created by Viswanath Reddy on 03/05/23.
//

import SwiftUI

enum StyleType {
    case title
    case title1
    case body
    case medium
    case small
    case subheadline
    case subheadline1
}

struct TextStyle: ViewModifier {
    var type:StyleType
    
    init(_ type: StyleType) {
        self.type = type
    }
    
    func body(content: Content) -> some View {
        switch type {
        case .title:
            title(content)
        case .title1:
            title1(content)
        case .body:
            body(content)
        case .medium:
            medium(content)
        case .small:
            medium(content)
        case .subheadline:
            subheadline(content)
        case .subheadline1:
            subheadline1(content)
        }
    }
    
    private func title(_ content: Content) -> some View {
        content
            .font(.circular(size: 28, weight: .bold))
            .foregroundColor(Color.primary)
    }
    
    private func title1(_ content: Content) -> some View {
        content
            .font(.circular(size: 17, weight: .bold))
            .foregroundColor(Color.primary)
    }
    
    
    private func body(_ content: Content) -> some View {
        content
            .font(.circular(size: 17, weight: .light))
            .foregroundColor(.primary)
    }
    
    private func medium(_ content: Content) -> some View {
        content
            .font(.circular(size: 20, weight: .medium))
            .foregroundColor(.primary)
    }
    
    private func small(_ content: Content) -> some View {
        content
            .font(.circular(size: 12, weight: .book))
            .foregroundColor(.primary)
    }
    
    private func subheadline(_ content: Content) -> some View {
        content
            .font(.circular(size: 15, weight: .book))
            .foregroundColor(Color.primary)
    }
    
    private func subheadline1(_ content: Content) -> some View {
        content
            .font(.circular(size: 15, weight: .book))
            .foregroundColor(Color.lightGrayText)
    }
}

extension View {
    func style(_ type: StyleType) -> some View {
        modifier(TextStyle(type))
    }
}

