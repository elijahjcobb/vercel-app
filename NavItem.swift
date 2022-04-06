//
//  NavItem.swift
//  Vercel
//
//  Created by Elijah Cobb on 4/6/22.
//

import SwiftUI

struct NavItem<Content: View>: View {
    
    let index: Int
    let icon: String
    let name: String
    let content: Content
    
    var body: some View {
        NavigationView {
            content
                .navigationTitle(name)
        }.tabItem({
            Image(systemName: icon)
            Text(name)
        }).tag(index)
    }
}
