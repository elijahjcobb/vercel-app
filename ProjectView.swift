//
//  ProjectView.swift
//  Vercel
//
//  Created by Elijah Cobb on 4/6/22.
//

import SwiftUI

struct ProjectRowView: View {
    let img: String?
    let left: String
    let right: String
    
    var body: some View {
        HStack {
            if let image = img {
                Image(systemName: image)
            }
            Text(left)
                .bold()
            Spacer()
            Text(right)
        }
    }
}

struct ProjectView: View {
    
    var project: Project;
    
    
    var body: some View {
        List {
            Section(header: Text("Project")) {
                ProjectRowView(img: "folder", left: "Name", right: project.name)
                ProjectRowView(img: "gearshape.2", left: "Framework", right: project.framework)
                ProjectRowView(img: "number", left: "NodeJS Version", right: project.nodeVersion)
                ProjectRowView(img: "calendar", left: "Updated At", right: Date(timeIntervalSince1970: TimeInterval(project.updatedAt)).formatted())
            }
            Section(header: Text("GitHub")) {
                ProjectRowView(img: "building.columns.fill", left: "Org", right: project.link.org)
                ProjectRowView(img: "scroll.fill", left: "Repo", right: project.link.repo)
                ProjectRowView(img: "arrow.triangle.branch", left: "Branch", right: project.link.productionBranch)
            }
            Section(header: Text("Deployments")) {
                ForEach(project.latestDeployments, id: \.id) { deployment in
                    ProjectRowView(img: "person.fill", left: deployment.meta.githubCommitAuthorName, right: deployment.meta.githubCommitMessage)
                }
            }
        }
        .listStyle(GroupedListStyle())
        .navigationTitle(project.name)
        .toolbar {
            Link(destination: URL(string: "https://github.com/" + project.link.org + "/" + project.link.repo)!) {
                Image(systemName: "chevron.left.forwardslash.chevron.right")
            }
        }
    }
}
