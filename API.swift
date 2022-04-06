//
//  API.swift
//  Vercel
//
//  Created by Elijah Cobb on 4/6/22.
//

import Foundation

struct ProjectLink: Codable {
    let type: String
    let repo: String
    let repoId: Int
    let org: String
    let gitCredential: String?
    let productionBranch: String
    let createdAt: Int
    let updatedAt: Int
}

struct ProjectDeploymentMeta: Codable {
    let githubCommitAuthorName: String
    let githubCommitMessage: String
    let githubCommitRef: String
    let githubOrg: String
    let githubRepo: String
}

struct ProjectDeployment: Codable {
    let alias: [String]
    let id: String
    let meta: ProjectDeploymentMeta
}

struct Project: Codable, Identifiable {
    let accountId: String
    let autoExposeSystemEnvs: Bool
    let createdAt: Int
    let directoryListing: Bool
    let framework: String
    let name: String
    let gitForkProtection: Bool
    let nodeVersion: String
    let serverlessFunctionRegion: String
    let sourceFilesOutsideRootDirectory: Bool
    let updatedAt: Int
    let live: Bool
    let link: ProjectLink
    let id: String
    let latestDeployments: [ProjectDeployment]
}

struct ProjectResponse: Codable {
    let projects: [Project]
}

struct Event: Codable, Identifiable {
    let id: String
    let text: String
    let createdAt: Int
}

struct EventsResponse: Codable {
    let events: [Event]
}

func getVercelToken() -> String {
    return UserDefaults.standard.string(forKey: "token") ?? ""
}

func setVercelToken(_ token: String) {
    UserDefaults.standard.set(token, forKey: "token")
}

class API : ObservableObject{
    @Published var projects = [Project]()
    
    func loadProjects(token: String, completion:@escaping ([Project]) -> ()) {
        guard let url = URL(string: "https://api.vercel.com/v8/projects") else {
            print("Invalid url...")
            return
        }
        var request = URLRequest(url: url)
        request.setValue("Bearer " + token, forHTTPHeaderField: "Authorization");
        URLSession.shared.dataTask(with: request) { d, response, error in
            DispatchQueue.main.async {
                guard let data = d else {
                    completion([])
                     return
                }
                guard let res = try? JSONDecoder().decode(ProjectResponse.self, from: data) else {
                    completion([])
                     return
                }
                completion(res.projects)
            }
            
            
        }.resume()
    }
    
    func loadEvents(token: String, completion:@escaping ([Event]) -> ()) {
        guard let url = URL(string: "https://api.vercel.com/v3/events") else {
            print("Invalid url...")
            return
        }
        var request = URLRequest(url: url)
        request.setValue("Bearer " + token, forHTTPHeaderField: "Authorization");
        URLSession.shared.dataTask(with: request) { d, response, error in
            DispatchQueue.main.async {
                guard let data = d else {
                    completion([])
                     return
                }
                guard let res = try? JSONDecoder().decode(EventsResponse.self, from: data) else {
                    completion([])
                     return
                }
                completion(res.events)
            }
            
            
        }.resume()
    }
    

}
