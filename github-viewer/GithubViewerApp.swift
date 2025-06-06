//
//  github_viewerApp.swift
//  github-viewer
//
//  Created by Laurent Meert on 05/06/2025.
//

import SwiftUI

@main
struct GithubViewerApp: App {
    
    /// Instance of the app container for injection
    private let container = AppContainer()
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(container)
            
        }
    }
}
