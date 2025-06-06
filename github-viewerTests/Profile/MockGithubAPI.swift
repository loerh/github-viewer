//
//  MockGithubAPI.swift
//  github-viewer
//
//  Created by Laurent Meert on 06/06/2025.
//

@testable import github_viewer
import Foundation

final class MockGitHubAPI: GitHubAPIProtocol {
    
    var shouldReturnNetworkError = false
    var shouldReturnNotFound = false

    func fetchRepos(for username: String) async throws -> [Repository] {
        if shouldReturnNotFound {
            throw GitHubAPIError.notFound
        }
        if shouldReturnNetworkError {
            throw GitHubAPIError.network
        }
        return [
            Repository(id: 1, name: "Repo1", language: "Swift"),
            Repository(id: 2, name: "Repo2", language: nil)
        ]
    }
    
    func fetchUser(for username: String) async throws -> GitHubUser {
        if shouldReturnNotFound {
            throw GitHubAPIError.notFound
        }
        if shouldReturnNetworkError {
            throw GitHubAPIError.network
        }
        
        return GitHubUser(username: "helloworld", avatarURL: nil)
    }
}
