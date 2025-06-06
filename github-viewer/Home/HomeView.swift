//
//  HomeView.swift
//  github-viewer
//
//  Created by Laurent Meert on 05/06/2025.
//

import SwiftUI

/**
 The home view implementation that allows you to look for a Github user.
 */
struct HomeView: View {
    
    /// Keep track of username text field changes.
    @State private var username = ""
    
    /// The app container to access view models and inherent data.
    @EnvironmentObject var container: AppContainer

    var body: some View {
        NavigationStack {
            VStack {
                
                // Header/navigation
                VStack {
                    Text("GitHub Viewer")
                        .padding()
                    Rectangle()
                        .frame(height: 1)
                        .foregroundStyle(.gray)
                }
                .frame(maxWidth: .infinity)
                .background(Color.navigationBackground)
                .foregroundStyle(.black)
                
                Spacer()
                
                // Search text field
                TextField("Username", text: $username)
                    .padding(.horizontal)
                    .textFieldStyle(.roundedBorder)
                
                // Search button
                NavigationLink(destination: ProfileView(viewModel: container.makeProfileViewModel(username: username))) {
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
