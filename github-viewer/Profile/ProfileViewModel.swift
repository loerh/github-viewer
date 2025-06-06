//
//  ProfileViewModel.swift
//  github-viewer
//
//  Created by Laurent Meert on 05/06/2025.
//

import Foundation

/**
 The view model responsible for business logic of profile view.
 */
@MainActor
class ProfileViewModel: ObservableObject {
    @Published var user: GitHubUser?
    @Published var repos: [Repository] = []
    @Published var error: GitHubAPIError?
    
    private let apiService: GitHubAPIProtocol
    private let username: String
    
    /**
     Custom initialiser for dependency injection
     */
    init(apiService: GitHubAPIProtocol,
         username: String) {
        self.apiService = apiService
        self.username = username
    }

    /**
     Loads profile related data.
     */
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
