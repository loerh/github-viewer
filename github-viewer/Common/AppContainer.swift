//
//  AppContainer.swift
//  github-viewer
//
//  Created by Laurent Meert on 06/06/2025.
//
import Combine

protocol AppContainable: ObservableObject {
    /**
     Creates profile view model.
     - parameter username: The username to look for on Github API.
     - returns The profile view model, if no error is thrown.
     */
    func makeProfileViewModel(username: String) async -> ProfileViewModel
}

/**
 App side implementation of the AppContainable
 */
class AppContainer: AppContainable {
    
    /// Reference of an API service instance.
    private lazy var apiService: GitHubAPIProtocol = GitHubAPI()
    
    @MainActor
    func makeProfileViewModel(username: String) -> ProfileViewModel {
        ProfileViewModel(apiService: apiService, username: username)
    }
}
