//
//  HomeView.swift
//  github-viewer
//
//  Created by Laurent Meert on 05/06/2025.
//

import SwiftUI

struct HomeView: View {
    @State private var username = ""
    @State private var showProfile = false

    var body: some View {
        NavigationStack {
            VStack {
                VStack {
                    Text("GitHub Viewer")
                        .padding()
                    Rectangle()
                        .frame(height: 1)
                        .foregroundStyle(.gray)
                }
                .frame(maxWidth: .infinity)
                .background(Color(red: 247/255, green: 247/255, blue: 247/255))
                .foregroundStyle(.black)
                
                Spacer()
                
                TextField("Username", text: $username)
                    .padding(.horizontal)
                    .textFieldStyle(.roundedBorder)
                
                NavigationLink(destination: ProfileView(username: username)) {
                    Text("Search")
                        .foregroundStyle(.blue)
                }
                .disabled(username.isEmpty)
                .padding(.top, 16)

                Spacer()
            }
        }
    }
}

#Preview {
    HomeView()
}
