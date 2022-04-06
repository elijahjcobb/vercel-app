//
//  ProjectsView.swift
//  Vercel
//
//  Created by Elijah Cobb on 4/6/22.
//

import SwiftUI

struct ProjectsView: View {
    
    @State var projects: [Project] = []
    var token: String;
    
    func loadProjects() {
        API().loadProjects(token: token) { p in
            self.projects = p
        }
    }
    
    var body: some View {
        List(projects) { project in
            NavigationLink(destination: ProjectView(project: project)) {
                Text(project.name)
            }
        }
        .refreshable {
            loadProjects()
        }
        .onAppear {
            if projects.isEmpty {
                loadProjects()
            }
        }
    }
}
