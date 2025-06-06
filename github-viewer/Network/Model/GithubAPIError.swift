//
//  GithubAPIError.swift
//  github-viewer
//
//  Created by Laurent Meert on 05/06/2025.
//

import Foundation

/**
 Implementation of Github API specific errors.
 */
enum GitHubAPIError: Error, LocalizedError {
    case network, notFound

    var errorDescription: String? {
        switch self {
        case .network:
            return "A network error has occurred. Check your Internet connection and try again later."
        case .notFound:
            return "User not found. Please enter another name"
        }
    }
}

extension GitHubAPIError: Identifiable {
    var id: String { self.localizedDescription }
}
