//
//  SettingsView.swift
//  Vercel
//
//  Created by Elijah Cobb on 4/6/22.
//

import SwiftUI

struct SettingsView: View {
    
    @Binding var token: String;
    
    var body: some View {
        List {
            Section(header: Text("Vercel Token")) {
                SecureField("Token", text: $token)
                    .submitLabel(.done)
                    .keyboardType(.asciiCapable)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .onSubmit {
                        setVercelToken(token)
                    }
            }
        }.listStyle(GroupedListStyle())
    }
}
