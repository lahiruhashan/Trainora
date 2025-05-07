//
//  SignInViewModelTests.swift
//  Trainora
//
//  Created by Lahiru Hashan on 5/7/25.
//

import XCTest
import Combine
@testable import Trainora

final class SignInViewModelTests: XCTestCase {
    private var viewModel: SignInViewModel!
    private var mockService: MockUserProfileService!
    private var userSession: UserSession!
    private var appState: AppState!
    private var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        mockService = MockUserProfileService()
        userSession = UserSession()
        appState = AppState()
        cancellables = []
        viewModel = SignInViewModel(
            userProfileService: mockService,
            userSession: userSession,
            appState: appState
        )
    }

    override func tearDown() {
        viewModel = nil
        mockService = nil
        userSession = nil
        appState = nil
        cancellables = nil
        super.tearDown()
    }

    func testSignInSuccess() {
        // Given
        let expectedProfile = UserProfile(
            id: UUID(),
            firstName: "John",
            lastName: "Doe",
            email: "john@example.com",
            mobileNumber: "1234567890",
            password: "password123",
            dateOfBirth: Date(),
            weight: 75.0,
            height: 180.0,
            profileImageName: "profile",
            experience: .intermediate,
            gender: .male,
            age: 30
        )

        mockService.mockUserProfile = expectedProfile
        viewModel.email = expectedProfile.email
        viewModel.password = expectedProfile.password

        let expectation = self.expectation(description: "Sign in should succeed")

        viewModel.handleSignIn()

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            XCTAssertFalse(self.viewModel.showInvalidCredentialsAlert)
            XCTAssertTrue(self.appState.isSignedIn)
            XCTAssertEqual(self.userSession.currentUser, expectedProfile)
            XCTAssertEqual(self.appState.loggedInUserName, expectedProfile.firstName)
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1.0, handler: nil)
    }

    func testSignInFailure() {
        // Given
        mockService.shouldFailAuthentication = true
        viewModel.email = "invalid@example.com"
        viewModel.password = "wrongpass"

        let expectation = self.expectation(description: "Sign in should fail")

        viewModel.handleSignIn()

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            XCTAssertTrue(self.viewModel.showInvalidCredentialsAlert)
            XCTAssertFalse(self.appState.isSignedIn)
            XCTAssertNil(self.userSession.currentUser)
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1.0, handler: nil)
    }

    func testSignInWithEmptyFieldsShowsAlert() {
        // Given
        viewModel.email = ""
        viewModel.password = ""

        viewModel.handleSignIn()

        XCTAssertTrue(viewModel.showInvalidCredentialsAlert)
        XCTAssertFalse(appState.isSignedIn)
        XCTAssertNil(userSession.currentUser)
    }
}
