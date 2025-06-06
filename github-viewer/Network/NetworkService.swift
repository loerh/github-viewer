//
//  NetworkService.swift
//  github-viewer
//
//  Created by Laurent Meert on 05/06/2025.
//
import Foundation

protocol GitHubAPIProtocol {
    /**
     Fetches the list of repos for a user.
     - parameter username The username to look for on Github API
     - returns The list of repositories, if no error is thrown
     */
    func fetchRepos(for username: String) async throws -> [Repository]
    
    /**
     Fetches the list of repos for a user.
     - parameter username The username to look for on Github API
     - returns The user, if no error is thrown
     */
    func fetchUser(for username: String) async throws -> GitHubUser
}

/**
 App implementation of GitHubAPIProtocol
 */
class GitHubAPI: GitHubAPIProtocol {
    
    private let baseURL = "https://api.github.com"
    private var usersURL: String { "\(baseURL)/users" }
    
    func fetchRepos(for username: String) async throws -> [Repository] {
        try await fetch(from: "\(usersURL)/\(username)/repos")
    }

    func fetchUser(for username: String) async throws -> GitHubUser {
        try await fetch(from: "\(usersURL)/\(username)")
    }
    
    private func fetch<T>(from url: String) async throws -> T where T: Decodable {
        
        guard let url = URL(string: url) else {
            throw GitHubAPIError.network
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw GitHubAPIError.network
        }

        switch httpResponse.statusCode {
        case 200:
            return try JSONDecoder().decode(T.self, from: data)
        case 404:
            throw GitHubAPIError.notFound
        default:
            throw GitHubAPIError.network
        }
    }
}
