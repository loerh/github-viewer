//
//  ProfileView.swift
//  github-viewer
//
//  Created by Laurent Meert on 05/06/2025.
//

import SwiftUI

/**
 The profile view implementation that shows a detailed view of the user and its repositories.
 */
struct ProfileView: View {
    @StateObject var viewModel : ProfileViewModel
    
    var body: some View {
        
        ZStack {
            VStack {
                // User nav/header view
                if let user = viewModel.user {
                    VStack {
                        AsyncImage(url: user.avatarURL) { image in
                            image.resizable()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 120, height: 120)
                        .clipShape(Circle())
                        
                        Text(user.login)
                            .font(.title2)
                            .padding(.top, 4)
                        
                        Rectangle()
                            .frame(height: 1)
                            .foregroundStyle(.gray)
                    }
                    .frame(maxWidth: .infinity)
                    .background(Color.navigationBackground)
                }
                
                // Repos list
                List(viewModel.repos) { repo in
                    VStack(alignment: .leading) {
                        Text(repo.name)
                            .font(.headline)
                        Text(repo.language ?? "Unknown")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
                .listStyle(.plain)
            }
            .task {
                await viewModel.loadProfile()
            }
            .alert(item: $viewModel.error) { error in
                Alert(title: Text("Error"), message: Text(error.localizedDescription), dismissButton: .default(Text("OK")))
            }
        }
        .navigationTitle("Profile")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    ProfileView(viewModel: ProfileViewModel(apiService: GitHubAPI(), username: "loerh"))
}
