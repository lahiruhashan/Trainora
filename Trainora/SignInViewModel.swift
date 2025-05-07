//
//  SignInViewModel.swift
//  Trainora
//
//  Created by Lahiru Hashan on 5/7/25.
//

import SwiftUI
import Combine

class SignInViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var showInvalidCredentialsAlert = false

    private var cancellables = Set<AnyCancellable>()
    
    private let userProfileService: UserProfileServiceProtocol
    private let userSession: UserSession
    private let appState: AppState

    init(userProfileService: UserProfileServiceProtocol, userSession: UserSession, appState: AppState) {
        self.userProfileService = userProfileService
        self.userSession = userSession
        self.appState = appState
    }

    func handleSignIn() {
        guard !email.isEmpty, !password.isEmpty else {
            showInvalidCredentialsAlert = true
            return
        }

        userProfileService
            .getUserProfile(email: email, password: password)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] profile in
                guard let self = self else { return }
                if let profile = profile {
                    self.userSession.login(with: profile)
                    self.appState.isSignedIn = true
                    self.appState.loggedInUserName = profile.firstName
                } else {
                    self.showInvalidCredentialsAlert = true
                }
            }
            .store(in: &cancellables)
    }
}

