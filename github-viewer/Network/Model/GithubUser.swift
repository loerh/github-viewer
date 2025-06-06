//
//  GithubUser.swift
//  github-viewer
//
//  Created by Laurent Meert on 05/06/2025.
//

import Foundation

struct GitHubUser: Codable {
    let login: String
    let avatar_url: URL?
}
