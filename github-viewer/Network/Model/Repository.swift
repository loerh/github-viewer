//
//  Repository.swift
//  github-viewer
//
//  Created by Laurent Meert on 05/06/2025.
//

import Foundation

/**
 A model representation of a Github user's repository from repos API response.
 */
struct Repository: Codable, Identifiable {
    let id: Int
    let name: String
    let language: String?
}
