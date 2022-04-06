//
//  ContentView.swift
//  Vercel
//
//  Created by Elijah Cobb on 4/6/22.
//

import SwiftUI

struct ContentView: View {
    
    @State var token: String = getVercelToken()
    
    var body: some View {
        TabView {
            NavItem(index: 0, icon: "briefcase", name: "Projects", content: ProjectsView(token: token))
            NavItem(index: 1, icon: "calendar.day.timeline.right", name: "Events", content: EventsView(token: token))
            NavItem(index: 2, icon: "gearshape.2.fill", name: "Settings", content: SettingsView(token: $token))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
