//
//  AppContainer.swift
//  github-viewer
//
//  Created by Laurent Meert on 06/06/2025.
//
import Combine

protocol AppContainable: ObservableObject {
    func makeProfileViewModel(username: String) async -> ProfileViewModel
}

class AppContainer: AppContainable {
    
    private lazy var apiService: GitHubAPIProtocol = GitHubAPI()
    
    @MainActor
    func makeProfileViewModel(username: String) -> ProfileViewModel {
        ProfileViewModel(apiService: apiService, username: username)
    }
}
