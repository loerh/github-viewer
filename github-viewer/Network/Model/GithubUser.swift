//
//  GithubUser.swift
//  github-viewer
//
//  Created by Laurent Meert on 05/06/2025.
//

import Foundation

/**
 A model representation of a Github user from API response
 */
struct GitHubUser: Codable {
    
    enum CodingKeys: String, CodingKey {
        case username = "login"
        case avatarURL = "avatar_url"
    }
    
    let username: String
    let avatarURL: URL?
}
