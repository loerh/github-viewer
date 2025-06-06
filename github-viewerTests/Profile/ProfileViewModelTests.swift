//
//  ProfileViewModelTests.swift
//  github-viewer
//
//  Created by Laurent Meert on 06/06/2025.
//

import XCTest
@testable import github_viewer

class ProfileViewModelTests: XCTestCase {
    
    private var sut: ProfileViewModel!
    private var mockAPIService: MockGitHubAPI!
    
    override func setUp() async throws {
        try await super.setUp()
        mockAPIService = MockGitHubAPI()
        sut = await ProfileViewModel(apiService: mockAPIService, username: "test")
    }
    
    override func tearDown() async throws {
        try await super.tearDown()
        mockAPIService = nil
        sut = nil
    }
    
    func test_loadProfile_success() async {
        await sut.loadProfile()
        let error = await sut.error
        XCTAssertNil(error)
        let user = await sut.user
        XCTAssertNotNil(user)
    }
    
    func test_loadProfile_networkError() async {
        mockAPIService.shouldReturnNetworkError = true
        await sut.loadProfile()
        let error = await sut.error
        XCTAssertNotNil(error)
        let user = await sut.user
        XCTAssertNil(user)
        let repos = await sut.repos
        XCTAssert(repos.isEmpty)
    }
    
    func test_loadProfile_notFoundError() async {
        mockAPIService.shouldReturnNotFound = true
        await sut.loadProfile()
        let error = await sut.error
        XCTAssertNotNil(error)
        let user = await sut.user
        XCTAssertNil(user)
        let repos = await sut.repos
        XCTAssert(repos.isEmpty)
    }
}
