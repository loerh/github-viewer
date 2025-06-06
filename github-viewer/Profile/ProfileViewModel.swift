//
//  ProfileViewModel.swift
//  github-viewer
//
//  Created by Laurent Meert on 05/06/2025.
//

import Foundation

@MainActor
class ProfileViewModel: ObservableObject {
    @Published var user: GitHubUser?
    @Published var repos: [Repository] = []
    @Published var error: GitHubAPIError?

    func loadProfile(for username: String) async {
        do {
            async let user = GitHubAPI.fetchUser(for: username)
            async let repos = GitHubAPI.fetchRepos(for: username)

            self.user = try await user
            self.repos = try await repos
        } catch let error as GitHubAPIError {
            self.error = error
        } catch {
            self.error = .network
        }
    }
}
