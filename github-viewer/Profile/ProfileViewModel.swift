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
    
    private let apiService: GitHubAPIProtocol
    private let username: String
    
    init(apiService: GitHubAPIProtocol,
         username: String) {
        self.apiService = apiService
        self.username = username
    }

    func loadProfile() async {
        do {
            async let user = apiService.fetchUser(for: username)
            async let repos = apiService.fetchRepos(for: username)

            self.user = try await user
            self.repos = try await repos
        } catch let error as GitHubAPIError {
            self.error = error
        } catch {
            self.error = .network
        }
    }
}
