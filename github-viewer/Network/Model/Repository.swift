//
//  Repository.swift
//  github-viewer
//
//  Created by Laurent Meert on 05/06/2025.
//

import Foundation

struct Repository: Codable, Identifiable {
    let id: Int
    let name: String
    let language: String?
}
