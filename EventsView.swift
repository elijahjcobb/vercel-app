//
//  Events.swift
//  Vercel
//
//  Created by Elijah Cobb on 4/6/22.
//

import SwiftUI

struct EventsView: View {
    
    @State var events: [Event] = []
    var token: String;
    
    func loadEvents() {
        API().loadEvents(token: token) { e in
            self.events = e
        }
    }
    
    var body: some View {
        List(events) { event in
            Text(event.text)
        }
        .refreshable {
            loadEvents()
        }
        .onAppear {
            if events.isEmpty {
                loadEvents()
            }
        }
    }
    
}
