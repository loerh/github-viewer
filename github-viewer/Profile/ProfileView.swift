//
//  ProfileView.swift
//  github-viewer
//
//  Created by Laurent Meert on 05/06/2025.
//

import SwiftUI

struct ProfileView: View {
    @StateObject var viewModel : ProfileViewModel
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        
        ZStack {
            VStack {
                if let user = viewModel.user {
                    AsyncImage(url: user.avatar_url) { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 120, height: 120)
                    .clipShape(Circle())
                    
                    Text(user.login)
                        .font(.title2)
                        .padding(.top, 4)
                }
                
                List(viewModel.repos) { repo in
                    VStack(alignment: .leading) {
                        Text(repo.name)
                            .font(.headline)
                        Text(repo.language ?? "Unknown")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
                
                
            }
            .task {
                await viewModel.loadProfile()
            }
            .alert(item: $viewModel.error) { error in
                Alert(title: Text("Error"), message: Text(error.localizedDescription), dismissButton: .default(Text("OK")))
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    ProfileView(viewModel: ProfileViewModel(apiService: GitHubAPI(), username: "loerh"))
}
