//
//  NetworkService.swift
//  github-viewer
//
//  Created by Laurent Meert on 05/06/2025.
//
import Foundation

protocol GithubAPIProtocol {
    func fetchRepos(for username: String) async throws -> [Repository]
    func fetchUser(for username: String) async throws -> GitHubUser
}

class GitHubAPI {
    static func fetchRepos(for username: String) async throws -> [Repository] {
        let url = URL(string: "https://api.github.com/users/\(username)/repos")!
        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw GitHubAPIError.network
        }

        switch httpResponse.statusCode {
        case 200:
            return try JSONDecoder().decode([Repository].self, from: data)
        case 404:
            throw GitHubAPIError.notFound
        default:
            throw GitHubAPIError.network
        }
    }

    static func fetchUser(for username: String) async throws -> GitHubUser {
        let url = URL(string: "https://api.github.com/users/\(username)")!
        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw GitHubAPIError.network
        }

        switch httpResponse.statusCode {
        case 200:
            return try JSONDecoder().decode(GitHubUser.self, from: data)
        case 404:
            throw GitHubAPIError.notFound
        default:
            throw GitHubAPIError.network
        }
    }
}
